import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:get/get.dart';

class CustomSheet extends StatefulWidget {
  final Widget child;
  final Widget sheet;

  CustomSheet({this.child, this.sheet});

  @override
  State<StatefulWidget> createState() => _SheetState();
}

class _SheetState extends State<CustomSheet> with SingleTickerProviderStateMixin {
  var sheetMarginBottom = 0.0;
  var sheetMinHeight = 100.0;
  var sheetMaxHeight = 400.0;
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _controller.addListener(() {
      setState(() {
        sheetMarginBottom = _animation.value.toDouble();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          Positioned.fill(child: Container(color: Colors.blue)),
          // Positioned(
          //   right: 0,
          //   left: 0,
          //   bottom: 10,
          //   child: Container(
          //     color: Colors.red,
          //     height: 120,
          //   ),
          // ),
          _bottomSheet2()
        ],
      );
    });
  }

  _bottomSheet2() {
    return Positioned(
      right: 0,
      left: 0,
      bottom: sheetMarginBottom,
      child: GestureDetector(
        onVerticalDragEnd: (DragEndDetails details){
          print('velocity ${details.primaryVelocity}');
          // _runAnimation();
          _runAnimation2(details.velocity.pixelsPerSecond, Size(100, context.width));
        },
        onVerticalDragUpdate: (DragUpdateDetails detail) => _dragUpdate(detail.primaryDelta),
        child: Container(
          color: Colors.red,
          height: 100,
        ),
      ),
    );
  }

  _dragUpdate(double dy) {
    sheetMarginBottom -= dy;
    print(sheetMarginBottom);
    if (sheetMarginBottom <= 0) {
      sheetMarginBottom = 0;
    } else if (sheetMarginBottom >= sheetMaxHeight - sheetMinHeight) {
      sheetMarginBottom = sheetMaxHeight - sheetMinHeight;
    }
    setState(() {});
  }

  Animation<int> _animation;

  void _runAnimation() {
    _animation = _controller.drive(
      IntTween()
    );
    _controller.reset();
    _controller.forward();
  }

  void _runAnimation2(Offset pixelsPerSecond, Size size) {
    _animation = _controller.drive(
        IntTween(
          begin: sheetMarginBottom.toInt(),
          end: sheetMarginBottom.toInt() + 20
        )
    );
    // Calculate the velocity relative to the unit interval, [0,1],
    // used by the animation controller.
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller.animateWith(simulation);
  }
}
