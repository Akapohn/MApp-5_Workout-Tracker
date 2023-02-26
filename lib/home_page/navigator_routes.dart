import 'package:flutter/material.dart';
import 'package:project/calendar_page/calendar_page.dart';
import 'package:project/home_page/home_page.dart';
import 'package:project/workout_page/workout_page.dart';

class NavigatorRoutes extends StatefulWidget {
  static const routeName = '/';
  const NavigatorRoutes({super.key});

  @override
  State<NavigatorRoutes> createState() => _NavigatorRoutes();
}

class _NavigatorRoutes extends State<NavigatorRoutes> {
  int _selectedIndex = 0;

  final List<Widget> _pageWidget = <Widget> [
    const HomePage(),
    const WorkoutPage(),
    const CalendarPage(),
  ];

  final List<BottomNavigationBarItem> _menuBar =
  const <BottomNavigationBarItem> [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.fitness_center),
      label: 'Workout',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_month),
      label: 'History',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageWidget.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: _menuBar,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}