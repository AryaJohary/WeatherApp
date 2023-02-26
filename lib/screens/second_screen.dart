import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:get/get.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Center(child: Text("Weather App"))), // heading of page
        body: Column(
          children: [
            TextField(
              controller: _cityController,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => const HomeScreen(),
                // ));  // using default navigation of flutter
                Get.to(() => HomeScreen(
                      cityName: _cityController.text,
                    )); // using get library
              },
              child: const Text("Check the weather"),
            )
          ],
        ));
  }
}
