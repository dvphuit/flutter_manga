import 'package:flutter/material.dart';
import 'dart:math';

class CustomSheet extends StatefulWidget {
  final Widget child;
  final Widget sheet;

  CustomSheet({this.child, this.sheet});

  @override
  State<StatefulWidget> createState() => _SheetState();
}

class _SheetState extends State<CustomSheet> with TickerProviderStateMixin {
  var currentMargin = 0.0;
  var minMarginBottom = 0.0;
  var maxMarginBottom = 300.0;

  var posToSnap = 150;

  var headerHeight = 100.0;

  double dragStartValue;
  Offset dragStartOffset;
  AnimationController controller;
  Animation<double> animation;
  void Function() currentFlingListener;

  @override
  void initState() {
    animation = AlwaysStoppedAnimation(0.0);
    controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [Positioned.fill(child: Container(color: Colors.blue)), _header()],
      );
    });
  }

  _header() {
    return Positioned(
      right: 0,
      left: 0,
      bottom: currentMargin,
      child: AnimatedBuilder(
        animation: animation,
        builder: (ctx, child) => GestureDetector(
          onVerticalDragEnd: onDragDone,
          onVerticalDragUpdate: onDragUpdate,
          onVerticalDragStart: onDragStart,
          child: Container(
            color: Colors.red,
            height: 100,
          ),
        ),
      ),
    );
  }

  void onDragStart(details) {
    controller.removeListener(currentFlingListener);
    controller.stop();
    animation = AlwaysStoppedAnimation(0.0);
    setState(() {
      dragStartOffset = details.globalPosition;
      dragStartValue = currentMargin;
    });
  }

  void onDragUpdate(details) {
    controller.stop();
    var newValue = dragStartValue - (details.globalPosition - dragStartOffset).dy;
    // if(newValue <= 0 || newValue >= 300) return;

    setState(() {
      currentMargin = newValue;
    });
  }

  void onDragDone(DragEndDetails details) {
    setState(() {
      dragStartOffset = null;
    });

    double velocity = details.primaryVelocity;
    if (velocity.abs() == 0) {
      return;
    }

    controller.duration = Duration(milliseconds: 750);

    currentFlingListener = flingListener(currentMargin);

    animation = Tween(begin: 0.0, end: velocity / 10).animate(
      CurvedAnimation(
        curve: Curves.fastLinearToSlowEaseIn,
        parent: controller,
      ),
    )
      ..addListener(currentFlingListener);

    controller
      ..reset()
      ..forward();
  }


  flingListener(double originalValue) {
    return () {
      double newValue = clamp(originalValue - animation.value, minMarginBottom, maxMarginBottom);
      print('value $newValue');

      if (newValue != currentMargin) {
        setState(() {
          currentMargin = newValue;
        });
        if(newValue == minMarginBottom || newValue == maxMarginBottom){
          controller.stop();
          controller.removeListener(currentFlingListener);
          return;
        }
        // if(newValue >= 220){
        //   controller.stop();
        //   controller.removeListener(currentFlingListener);
        //   _startSnap(maxMarginBottom);
        //   return;
        // }
        // if(newValue <= 70){
        //   controller.stop();
        //   controller.removeListener(currentFlingListener);
        //   _startSnap(minMarginBottom);
        //   return;
        // }
      }
    };
  }

  _startSnap(double marginBottom) {
    currentFlingListener = _snapListener();
    controller.duration = Duration(milliseconds: 250);
    animation = Tween(begin: currentMargin, end: marginBottom).animate(
      CurvedAnimation(
        curve: Curves.easeOutExpo,
        parent: controller,
      ),
    )..addListener(_snapListener);
    controller
      ..reset()
      ..forward();
  }

  _snapListener(){
    setState(() {
      currentMargin = animation.value;
      print('start snap $currentMargin');
    });
  }
}

double clamp<T extends num>(T number, T low, T high) => max(low * 1.0, min(number * 1.0, high * 1.0));

