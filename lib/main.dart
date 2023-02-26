import 'package:flutter/material.dart';
import 'workout_page/workout_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WorkoutPage()
    );
  }
}
