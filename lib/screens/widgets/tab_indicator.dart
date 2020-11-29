import 'package:flutter/widgets.dart';

class TabIndicator extends Decoration {
  final double size;
  final Color color;

  const TabIndicator({@required this.size, @required this.color});

  @override
  _Painter createBoxPainter([VoidCallback onChanged]) {
    return new _Painter(this, onChanged);
  }
}

class _Painter extends BoxPainter {
  final TabIndicator decoration;

  _Painter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration config) {
    assert(config != null);
    assert(config.size != null);

    final Paint paint = Paint()
      ..color = decoration.color ?? Color(0xff1967d2)
      ..style = PaintingStyle.fill;

    // final Offset circleOffset = offset + Offset(config.size.width / 2, config.size.height - decoration.size);
    // canvas.drawCircle(circleOffset, decoration.size, paint);

    var rect = Offset(offset.dx + 4, offset.dy + decoration.padding.vertical + 4) &
        Size(config.size.width - 8, config.size.height - 8);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(99)), paint);
  }
}
