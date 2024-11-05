import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:todo_app/home_screen.dart';

late final Box<Map<String, dynamic>> hiveBox;

void main() async {
  await Hive.initFlutter();
  hiveBox = await Hive.openBox("todo");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {"/": (context) => const HomeScreen()},
    );
  }
}
