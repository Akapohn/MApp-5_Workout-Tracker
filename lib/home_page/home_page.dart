import 'package:flutter/material.dart';
import 'package:project/home_page/user_info.dart';
import 'package:project/workout_page/workout_data.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<WorkoutData>(context, listen: false).initalizeWorkoutList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
        builder: (context, value, child) => Scaffold(
              body: Container(
                  alignment: Alignment.center,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UserInfo(
                          userName: value.getUserInfo(),
                        ),
                        Text("Today Workout"),
                        Text("")
                      ])),
            ));
  }
}
