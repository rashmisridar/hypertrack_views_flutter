import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hypertrack_views_flutter/hypertrack_views_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _currentLocation = 'Unknown';
  HypertrackViewsFlutter? views;

  @override
  void initState() {
    super.initState();
    views = HypertrackViewsFlutter(
        "W8MZlkQ8PvhOtw5FNDG3CXgqlnnvPr2onENDGjUxYFxGqEGpt-w-suqzs4gkI36gRN2NnzYL1Cjm4HPj5_2e5Q");
  }

  Future<void> testSnapshot() async {
    print("in testSnapshot"); //5BEE43AE-56F9-30D8-9199-828FDE897928
    var test =
        await views!.getDeviceUpdate("5BEE43AE-56F9-30D8-9199-828FDE897928");
    setState(() {
      _currentLocation = test.locationCoords.toString();
    });
  }

  Future<void> testStream() async {
    print("in testStream");
    views!
        .subscribeToDeviceUpdates("5BEE43AE-56F9-30D8-9199-828FDE897928")
        .listen((event) {
      setState(() {
        _currentLocation = event.locationCoords.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Column(
            children: [
              SizedBox(height: 50),
              Text(
                'Current location:',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                '$_currentLocation',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 50),
              ListTile(
                  leading: FloatingActionButton(
                      onPressed: testSnapshot, child: Icon(Icons.location_on)),
                  title: Text("getDeviceUpdate")),
              SizedBox(height: 10),
              ListTile(
                  leading: FloatingActionButton(
                      onPressed: testStream,
                      child: Icon(Icons.location_searching)),
                  title: Text("subscribeToDeviceUpdates")),
            ],
          )),
    );
  }
}
