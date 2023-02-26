import 'package:flutter/material.dart';
//import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/second_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // creates ui
    // whenever we refresh page, it gets called again
    return const GetMaterialApp(
      //home: HomeScreen(),
      home: SecondScreen(), // define the homescreen
    );
  }
}
