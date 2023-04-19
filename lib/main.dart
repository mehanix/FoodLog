import 'package:dezvapmobile/AddEditMealRoute.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MainWindowRoute.dart';
import 'MealAddedCongratsRoute.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Food Log',
        initialRoute: '/',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => MainWindowRoute(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/addedit': (context) => const AddEditMealRoute(),
          '/congrats': (context) => const MealAddedCongratsRoute(),

        },
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  // var current = WordPair.random();

  // void getNext() {
  //   current = WordPair.random();
  //   notifyListeners();
  // }

  // var favorites = <WordPair>[];

  // void toggleFavorite() {
  //   if (favorites.contains(current)) {
  //     favorites.remove(current);
  //   } else {
  //     favorites.add(current);
  //   }
  //   notifyListeners();
  // }
}
