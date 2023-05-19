import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutRoute extends StatelessWidget {
  const AboutRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About the app'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Made with <3"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image(image: AssetImage('assets/me.png'))),
          ),
          Text(
            " Nicoleta Ciaușu",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: _launchURL,
            child: const Text(
              'Github: @mehanix',
              style: TextStyle(
                fontSize: 30,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

_launchURL() async {
  Uri _url = Uri.parse('https://github.com/mehanix');
  if (await launchUrl(_url)) {
    await launchUrl(_url);
  } else {
    throw 'Could not launch $_url';
  }
}
