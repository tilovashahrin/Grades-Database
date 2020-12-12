import 'package:flutter/material.dart';
import 'list_grades.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forms and SQLite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListGrades(title: 'Forms and SQLite'),
    );
  }
}

