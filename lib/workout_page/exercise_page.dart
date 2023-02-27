import 'package:flutter/material.dart';
import 'package:project/workout_page/workout_data.dart';
import 'package:provider/provider.dart';

class ExercisePage extends StatefulWidget {
  final String workoutName;
  const ExercisePage({super.key, required this.workoutName});

  @override
  State<ExercisePage> createState() => _ExercisePage();
}

class _ExercisePage extends State<ExercisePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
        builder: (context, value, child) => Scaffold(
            appBar: AppBar(
              title: Text(widget.workoutName),
              actions: const [
                IconButton(onPressed: null, icon: Icon(Icons.edit))
              ],
            ),
            floatingActionButton: const FloatingActionButton(
              onPressed: null,
              child: Icon(Icons.add),
            ),
            body: ListView.builder(
              itemCount: value.numberOfExerciseInWorkout(widget.workoutName),
              itemBuilder: (context, index) => ListTile(
                title: Text(value
                    .getRelevantWorkout(widget.workoutName)
                    .exercises[index]
                    .name),
              ),
            )));
  }
}
