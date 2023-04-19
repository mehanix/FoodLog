import 'package:flutter/material.dart';

class AboutRoute extends StatelessWidget {
  const AboutRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About the app'),
      ),
      body: Center(
        child: Center(child: Text("Made with <3")),
      ),
    );
  }
}
