import 'dart:convert';
import 'package:flutter_application_1/data/models/city_model.dart';
import 'package:flutter_application_1/data/models/data_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // material ui is being used

// MVC architecture
// Model Values and Controllers

// data is present inside a .json file
// .json consists of key-value pairs
// we need to create a model out of .json format

class HomeScreen extends StatefulWidget {
  final String cityName;
  const HomeScreen({Key? key, required this.cityName}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  // _HomeScreenState() class is also private here
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true; // _ is used to make it private
  // also helps in memory alloocation

  @override
  void initState() {
    // called before building the UI
    super
        .initState(); // used for triggers so that we can analyse user behaviour
    _getData();
    // lifecycle of widget
    // init state - before buid i.e before creating the ui it initializes the widget variables and constants
    // build state - create the ui
    // dispose state - remove the ui

    // createState - called after initState. It created the widget
    // didChangeDependencies - dependency of state object changes via InheritedWidget
    // didUpdateWidget - widget configuration changes
    // deactivate - state is removed from tree but can be re-inserted before changing frame
    // dispose - remove permanently
  }

  cityModel? cityModelAPI;
  DataModel? dataModelAPI;
  _getData() async {
    // async is used to to wait till we get all the data from api
    String url2 =
        "https://geocoding-api.open-meteo.com/v1/search?name=${widget.cityName}";
    http.Response cityres = await http.get(Uri.parse(url2));
    cityModelAPI = cityModel.fromJson(json.decode(cityres.body));
    final double lat = cityModelAPI!.results![0].latitude!;
    final double log = cityModelAPI!.results![0].longitude!;

    String url1 =
        "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$log&hourly=temperature_2m";
    http.Response datares = await http.get(Uri.parse(url1));
    //dataFromAPI = DataModel.fromJson(
    //json.decode(res.body)); // "decode" converts string to map
    // debugPrint(dataFromAPI.hourlyUnits!
    //     .temperature2m); // ! is a NULL check operator i.e if API returns NULL, don't proceed

    dataModelAPI = DataModel.fromJson(json.decode(datares.body));
    _isLoading = false;
    setState(() {});
    //debugPrint(res.body);
  }

  final List _newList = [
    'Arya',
    'Kumar',
    'Johary',
    'Aman',
    'Andro',
    'Rohit',
    'Chakrwarty',
    'Dipendu',
    'Mukharjee'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.cityName),
        ),
        // body: Center(
        //   child:
        //       _isLoading // we are using the ternary operator for if-else conditions
        //           ? const CircularProgressIndicator()
        //           : Image.network(
        //               "https://i0.wp.com/uemgroup.s3.amazonaws.com/uploads/sites/3/2016/03/Boys_Hostel.jpg?fit=1024%2C768&ssl=1"),
        // ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                // used to view list
                scrollDirection: Axis.vertical, // write elements horizontally
                itemBuilder: (context, index) {
                  DateTime temp =
                      DateTime.parse(dataModelAPI!.hourly!.time![index]);
                  return Padding(
                    padding: const EdgeInsets.all(
                        16.0), // give space of 16 between each word
                    child:
                        // specify the child to print
                        // _newList[index],
                        // dataFromAPI!
                        //     .hourly!.time![index], // ! are for NULL checkers
                        Row(
                      children: [
                        Text(DateFormat('dd-MM-yyyy HH:mm a').format(temp)),
                        const Spacer(),
                        Text(dataModelAPI!.hourly!.temperature2m![index]
                            .toString()),
                      ],
                    ),
                  );
                },
                // itemCount: _newList.length,
                itemCount:
                    dataModelAPI!.hourly!.time!.length, // ! for NULL checker
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ));
  }
}
