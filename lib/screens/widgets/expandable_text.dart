import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText(
    this.text, {
    Key key,
    this.trimLines = 2,
    this.style,
  })  : assert(text != null),
        super(key: key);

  final String text;
  final int trimLines;
  final TextStyle style;

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _readMore = true;

  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        return RichText(
          softWrap: true,
          overflow: TextOverflow.clip,
          text: _createTextSpan(constraints),
          textAlign: TextAlign.justify,
        );
      },
    );
  }

  TextSpan _createTextSpan(BoxConstraints constraints) {
    var _link = TextSpan(
        text: _readMore ? "... read more" : " read less",
        style: TextStyle(
          color: Colors.blue,
        ),
        recognizer: TapGestureRecognizer()..onTap = _onTapLink);

    final text = TextSpan(
      text: widget.text,
    );
    // Layout and measure link
    TextPainter textPainter = TextPainter(
      text: _link,
      textDirection: TextDirection.rtl, //better to pass this from master widget if ltr and rtl both supported
      maxLines: widget.trimLines,
      ellipsis: '...',
    );
    textPainter.layout(minWidth: constraints.minWidth, maxWidth: constraints.maxWidth);
    final linkSize = textPainter.size;
    // Layout and measure text
    textPainter.text = text;
    textPainter.layout(minWidth: constraints.minWidth, maxWidth: constraints.maxWidth);
    final textSize = textPainter.size;
    // Get the endIndex of data
    int endIndex;
    final pos = textPainter.getPositionForOffset(Offset(
      textSize.width - linkSize.width,
      textSize.height,
    ));
    endIndex = textPainter.getOffsetBefore(pos.offset);

    if (textPainter.didExceedMaxLines) {
      return TextSpan(
        text: _readMore ? widget.text.substring(0, endIndex) : widget.text,
        style: widget.style,
        children: <TextSpan>[_link],
      );
    } else {
      return TextSpan(
        text: widget.text,
        style: widget.style
      );
    }
  }
}
