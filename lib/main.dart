import 'package:dezvapmobile/AddEditMealRoute.dart';
import 'package:dezvapmobile/util/database_helper.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MainWindowRoute.dart';
import 'MealAddedCongratsRoute.dart';
import 'model/FoodLog.dart';
import 'model/FoodLogList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/me.png"), context);
    return ChangeNotifierProvider<FoodLogProvider>(
      create: (context) => FoodLogProvider(),
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
          '/addedit': (context) => const AddEditMealRoute(
                prevFoodLog: null,
              ),
          '/congrats': (context) => const MealAddedCongratsRoute(),
        },
      ),
    );
  }
}
