import 'package:flutter/cupertino.dart';
import 'package:project/workout_page/hive_database.dart';
import 'workout.dart';
import 'exercise.dart';

class WorkoutData extends ChangeNotifier {
  final db = HiveDatabase();

  List<Workout> workoutList = [];

  // check first time on app
  void initalizeWorkoutList() {
    if (db.previousDateExists()) {
      workoutList = db.readData();
    } else {
      db.saveData(workoutList);
    }
  }

  // get the list
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  // get length
  int numberOfExerciseInWorkout(String wName) {
    Workout relevantWorkout = getRelevantWorkout(wName);

    return relevantWorkout.exercises.length;
  }

  // add workout
  void addWorkout(String name) {
    workoutList.add(Workout(name: name, exercises: []));

    notifyListeners();
    db.saveData(workoutList);
  }

  // add exercise
  void addExercise(String wName, String exerciseName, String type, String time,
      String weight, String reps, String sets) {
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == wName);

    relevantWorkout.exercises.add(Exercise(
        name: exerciseName,
        type: type,
        time: time,
        weight: weight,
        reps: reps,
        sets: sets));

    notifyListeners();
    db.saveData(workoutList);
  }

  // check
  void checkOffExercise(String wName, String exName) {
    Exercise relevantExercise = getRelevantExercise(wName, exName);

    relevantExercise.isCompleted = !relevantExercise.isCompleted;

    notifyListeners();
  }

  Workout getRelevantWorkout(String wName) {
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == wName);

    return relevantWorkout;
  }

  Exercise getRelevantExercise(String wName, String exName) {
    Workout relevantWorkout = getRelevantWorkout(wName);

    Exercise relevantExercise = relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exName);

    return relevantExercise;
  }
}
