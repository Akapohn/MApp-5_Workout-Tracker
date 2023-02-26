import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center),
              label: 'Workout'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'History'
          ),
        ],
      ),
    );
  }
}