import 'package:flutter/material.dart';
import 'package:project/components/workkout_tile.dart';
import 'package:project/workout_page/exercise_page.dart';
import 'package:project/workout_page/workout_data.dart';
import 'package:provider/provider.dart';
import '../components/my_textfield.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPage();
}

class _WorkoutPage extends State<WorkoutPage> {
  final _formKey = GlobalKey<FormState>();
  final newWorkoutController = TextEditingController();

  void createNewWorkout() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text("Name"),
                content: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: newWorkoutController,
                      validator: (value) {
                        return value!.isNotEmpty ? null : "Invalid Field";
                      },
                      decoration: const InputDecoration(
                          hintText: "Enter the workout name"),
                    )),
                actions: [
                  // Cancel btn
                  MaterialButton(
                    onPressed: cancel,
                    child: const Text("Cancel"),
                  ),
                  // Save btn
                  MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        save();
                      }
                    },
                    child: const Text("Save"),
                  ),
                ]));
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

  void goToWorkoutPage(String workoutName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExercisePage(workoutName: workoutName),
      ),
    );
  }

  void editWorkoutName(String currentWorkoutName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        content: MyTextField(
          controller: newWorkoutController,
          hintText: "Edit workout name",
        ),
        actions: [
          // save
          MaterialButton(
            onPressed: () {
              String newWorkoutName = newWorkoutController.text;
              Provider.of<WorkoutData>(context, listen: false).editWorkoutName(
                currentWorkoutName,
                newWorkoutName,
              );
              cancel();
            },
            color: Colors.black,
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          ),

          // cancel
          MaterialButton(
            onPressed: cancel,
            color: Colors.black,
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void deleteWorkout(String workoutName) {
    Provider.of<WorkoutData>(context, listen: false).deleteWorkout(workoutName);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
        builder: (context, value, child) => Scaffold(
            appBar: AppBar(title: const Text("Workout List")),
            floatingActionButton: FloatingActionButton(
              onPressed: createNewWorkout,
              child: const Icon(Icons.add),
            ),
            body: ListView.builder(
                itemCount: value.getWorkoutList().length,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          settings: const RouteSettings(name: "/ExercisePage"),
                          builder: (context) => ExercisePage(
                              workoutName:
                                  value.getWorkoutList()[index].name))),
                      child: WorkoutTile(
                        workoutName: value.getWorkoutList()[index].name,
                        onPressed: () =>
                            goToWorkoutPage(value.getWorkoutList()[index].name),
                        onEditTapped: (context) =>
                            editWorkoutName(value.getWorkoutList()[index].name),
                        onDeleteTapped: (context) =>
                            deleteWorkout(value.getWorkoutList()[index].name),
                      ),
                    ))));
  }
}

/*
ListTile(
                      title: Text(value.getWorkoutList()[index].name),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          settings: const RouteSettings(name: "/ExercisePage"),
                          builder: (context) => ExercisePage(
                              workoutName:
                                  value.getWorkoutList()[index].name))),
                    )
*/