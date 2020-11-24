import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart';

abstract class BaseScrapper {
  String baseUrl;

  Future<Document> getDocument({String path = "", String href}) async {
    var res = await Client().get(Uri.parse(href ?? '$baseUrl$path'));
    print('get document ${baseUrl + path}');
    if (res.statusCode == 200) {
      return parse(res.body);
    }
    throw Exception("can not parse document.");
  }
}
