import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'dart:async';

Route animatedTransitionMealAddedCongratsRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const MealAddedCongratsRoute(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      final tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class MealAddedCongratsRoute extends StatefulWidget {
  const MealAddedCongratsRoute({super.key});

  @override
  State<MealAddedCongratsRoute> createState() => _MealAddedCongratsRouteState();
}

class _MealAddedCongratsRouteState extends State<MealAddedCongratsRoute> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/fireworks.mp4');
    _initializeVideoPlayerFuture = _controller.initialize();

    // // Use the controller to loop the video.
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Congratulations!!!',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: 'Satisfy',
                  fontFamilyFallback: ['Roboto']),
            ),
          ),
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the VideoPlayerController has finished initialization, use
                // the data it provides to limit the aspect ratio of the video.
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(_controller),
                );
              } else {
                // If the VideoPlayerController is still initializing, show a
                // loading spinner.
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'You have successfully logged a new meal',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17,
                    ),
                    textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(child: Container()),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName("/"));
            },
            icon: Icon(Icons.add),
            label: Text("Go Back"),
          ),
        ])),
      ),
    );
  }
}
