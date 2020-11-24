import 'dart:math';

import 'package:flutter/material.dart';

class Indicator extends StatefulWidget {
  final int length;
  final double position;

  Indicator(this.length, this.position);

  @override
  State<StatefulWidget> createState() => IndicatorState();
}

class IndicatorState extends State<Indicator> {
  var index = 0.0;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: IndicatorPainter(widget.length, widget.position),
        child: Container(
          height: 4,
          width: 10.0 * widget.length,
        ));
  }

  void callback(int i) {
    setState(() {
      index = i.toDouble();
    });
  }
}

class IndicatorPainter extends CustomPainter {
  var _length = 0;
  var _padding = 10;
  var _position = 1.0;
  var startX = 0.0;

  IndicatorPainter(int length, double position) {
    this._length = length;
    this._position = position;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _style1(canvas, size);
  }

  void _style1(Canvas canvas, Size size) {
    var _dotPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 2
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    var _indicatorPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    //draw dots
    var centerX = size.width / 2;
    startX = centerX - (_length ~/ 2) * _padding;
    var centerY = size.height / 2;
    for (var i = 0; i < _length; i++) {
      // canvas.drawLine(Offset(startX + _padding * i, centerY),
      //     Offset(startX + _padding * i + 5, centerY), _dotPaint);

      canvas.drawCircle(Offset(startX + _padding * i, centerY), 2.5, _dotPaint);
    }

    //draw transition
    // var value = 2 * (_position.round() - _position);
    // var sx = value > 0 ? startX + _padding * (_position.ceil() - value) : startX + _padding * _position.toInt();
    // var ex = value > 0 ? startX + _padding * _position.round() : startX + _padding * (_position.toInt() - value);
    // print('position $_position / _value $value');
    // canvas.drawLine(Offset(sx, centerY), Offset(ex + 5, centerY), _indicatorPaint);

    // var value = max(_position > _length - 1 ? _position - _length : _position, 0);
    var value = _position > _length - 1 ? _position - _length : _position;
    // canvas.drawLine(
    //   Offset(startX + _padding * max(value, 0), centerY),
    //   Offset(startX + _padding * max(value, 0) + 5, centerY),
    //   _indicatorPaint,
    // );

    canvas.drawCircle(Offset(startX + _padding * max(value, 0), centerY), 3.5, _indicatorPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  bool hitTest(Offset position) {
    var index = ((position.dx - startX) / _padding).round();
    print("clicked $index");
    return false;
  }
}
