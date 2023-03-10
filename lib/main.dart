import 'package:flutter/material.dart';
import 'package:remote_signal/views/controllers_screen.dart';
import 'package:remote_signal/views/login_screen.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ControllersScreen();
  }
}
