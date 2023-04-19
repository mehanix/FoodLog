import 'package:flutter/material.dart';

import 'AddEditMealRoute.dart';

class LogMealRoute extends StatefulWidget {
  const LogMealRoute({
    super.key,
  });

  @override
  State<LogMealRoute> createState() => _LogMealRouteState();
}

class _LogMealRouteState extends State<LogMealRoute>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Color?> animatedColor;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);

    controller.forward();
    controller.repeat(reverse: true);

    Animatable<Color?> bgColor = TweenSequence<Color?>([
      TweenSequenceItem(
          weight: 1.0, tween: ColorTween(begin: Colors.red, end: Colors.pink)),
      TweenSequenceItem(
          weight: 1.0, tween: ColorTween(begin: Colors.pink, end: Colors.blue)),
      TweenSequenceItem(
          weight: 1.0, tween: ColorTween(begin: Colors.blue, end: Colors.green)),
      TweenSequenceItem(
          weight: 1.0, tween: ColorTween(begin: Colors.green, end: Colors.yellow)),
      TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(begin: Colors.yellow, end: Colors.red)),
    ]);
    animatedColor = bgColor.animate(controller);
    // animation =

    //       ..addListener(() {
    //         if (controller.isCompleted) {
    //           controller.repeat(reverse: true);
    //         }
    //         setState(() {
    //           // The state that has changed here is the animation object’s value.
    //         });
    //       });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.all(100.0),
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(2),
                  backgroundColor: animatedColor.value),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddEditMealRoute()),
                );
              },
              icon: Icon(Icons.add),
              label: Text(
                "Log new meal!",
                style: TextStyle(fontSize: 20),
              )),
        );
      },
    );
  }
}
