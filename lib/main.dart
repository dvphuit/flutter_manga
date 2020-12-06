import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_manga/screens/main_binding.dart';
import 'package:flutter_manga/screens/main_page.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';
import 'utils/app_theme.dart';
import 'utils/dependencies_injection.dart';

Future<void> main() async {
  await DependenciesInjection.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Manga',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: MainPage(),
      initialBinding: MainBinding(),
      getPages: AppPages.pages,
      onInit: () {
        print('on app init');
      },
      onDispose: () {
        print('on app dispose');
      },
    );
  }
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = CustomEditTextController({
      '#': TextStyle(color: Colors.grey),
      '-': TextStyle(color: Colors.red),
    });
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("AndroidMonks"),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: controller,
                  inputFormatters: [
                    CustomFormatter(),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.clear),
          onPressed: () => controller.clear(),
        ),
      ),
    );
  }
}

class CustomFormatter extends TextInputFormatter {
  var mask = '## - #### - #### - ####';
  final holder = '#';
  final separator = ' - ';

  var isDeleting = false;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    isDeleting = newValue.text.length < oldValue.text.length;

    var index = newValue.selection.baseOffset - (isDeleting ? 0 : 1);
    var char = isDeleting ? holder : newValue.text.characters.characterAt(index).toString();

    if (newValue.text.characters.length > mask.length || oldValue.text.characters.length == mask.length) {
      return _fillHolder(oldValue, char, true, isDeleting);
    }
    return _fillHolder(newValue, char, false, isDeleting);
  }

  TextEditingValue _fillHolder(TextEditingValue editor, String char, bool isHolderVisible, bool isDeleting) {
    var pointer = editor.selection.baseOffset + (isHolderVisible ? 1 : 0);
    pointer = min(pointer, mask.length);
    pointer = pointer + (_needJumpOverSeparator(pointer - 1) ? separator.length : 0);

    mask = mask.replaceRange(pointer - 1, pointer, char);

    var newPointer = 0;
    if (isDeleting) {
      newPointer = pointer - (_needJumpOverSeparator(pointer - (separator.length + 1)) ? (separator.length + 1) : 1);
    } else {
      newPointer = min(pointer + (_needJumpOverSeparator(pointer) ? separator.length : 0), mask.length);
    }

    return editor.copyWith(
      text: mask,
      selection: editor.selection.copyWith(
        baseOffset: newPointer,
        extentOffset: newPointer,
      ),
    );
  }

  _needJumpOverSeparator(int currentIndex) {
    return currentIndex < 0 ? false : currentIndex == mask.indexOf(separator, currentIndex);
  }
}

class CustomEditTextController extends TextEditingController {
  final Map<String, TextStyle> patternMap;

  CustomEditTextController(this.patternMap) : assert(patternMap != null);

  @override
  TextSpan buildTextSpan({TextStyle style, bool withComposing}) {
    List<TextSpan> spans = [];
    for (var i = 0; i < text.length; i++) {
      final char = text[i];
      spans.add(TextSpan(text: char, style: patternMap.containsKey(char) ? patternMap[char] : style));
    }
    return TextSpan(style: style, children: spans);
  }
}
