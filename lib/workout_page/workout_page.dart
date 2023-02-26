import 'package:flutter/material.dart';
import 'package:project/workout_page/exercise_page.dart';
import 'package:project/workout_page/workout_data.dart';
import 'package:provider/provider.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPage();
}

class _WorkoutPage extends State<WorkoutPage> {

  final newWorkoutController = TextEditingController();
  
  void createNewWorkout() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Name"),
          content: TextField(controller: newWorkoutController),
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
          ])
    );
  }

  void save() {
    String wName = newWorkoutController.text;
    Provider.of<WorkoutData>(context, listen: false).addWorkout(wName);
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newWorkoutController.clear();
  }
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => WorkoutData(),
        child:Consumer<WorkoutData>(
            builder: (context, value, child) => Scaffold(
                appBar: AppBar(
                  title: const Text("Workout List"),
                  actions: const [
                    IconButton(onPressed: null, icon: Icon(Icons.edit))
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: createNewWorkout,
                  child: const Icon(Icons.add),
                ),
                body: ListView.builder(
                  itemCount: value.getWorkoutList().length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(value.getWorkoutList()[index].name),
                    onTap: () =>
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) =>
                            ExercisePage(
                                workoutName: value.getWorkoutList()[index].name
                            ))
                        ),
                  )
                )
            )
        )
    );
  }
}