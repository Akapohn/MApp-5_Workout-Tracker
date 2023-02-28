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
  final exerciseNameController = TextEditingController();
  final weightController = TextEditingController();
  final repsController = TextEditingController();
  final setsController = TextEditingController();

  void createNewExercise() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text("Add a new exercise"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: exerciseNameController,
                    ),
                    TextField(
                      controller: weightController,
                    ),
                    TextField(
                      controller: repsController,
                    ),
                    TextField(
                      controller: setsController,
                    )
                  ],
                ),
                actions: [
                  // Save btn
                  MaterialButton(
                    onPressed: save,
                    child: const Text("Save"),
                  ),
                  // Cancel btn
                  MaterialButton(
                    onPressed: cancel,
                    child: const Text("Cancel"),
                  )
                ]));
  }

  void save() {
    String newExerciseName = exerciseNameController.text;
    String weight = weightController.text;
    String reps = repsController.text;
    String sets = setsController.text;
    Provider.of<WorkoutData>(context, listen: false).addExercise(widget.workoutName, newExerciseName, weight, reps, sets);
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    exerciseNameController.clear();
    weightController.clear();
    repsController.clear();
    setsController.clear();
  }

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
            floatingActionButton: FloatingActionButton(
              onPressed: createNewExercise,
              child: Icon(Icons.add),
            ),
            body: ListView.builder(
              itemCount: value.numberOfExerciseInWorkout(widget.workoutName),
              itemBuilder: (context, index) => ListTile(
                title: Text(value
                    .getRelevantWorkout(widget.workoutName)
                    .exercises[index]
                    .name),
                subtitle: Row(children: [
                  Chip(
                      label: Text(
                          "${value.getRelevantWorkout(widget.workoutName).exercises[index].weight} kg")),
                  Chip(
                      label: Text(
                          "${value.getRelevantWorkout(widget.workoutName).exercises[index].reps} reps")),
                  Chip(
                      label: Text(
                          "${value.getRelevantWorkout(widget.workoutName).exercises[index].sets} sets"))
                ]),
              ),
            )));
  }
}
