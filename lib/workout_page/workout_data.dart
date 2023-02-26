import 'package:flutter/cupertino.dart';

import 'workout.dart';
import 'exercise.dart';

class WorkoutData extends ChangeNotifier {
  List<Workout> workoutList = [
    Workout(
        name: "Set1",
        exercises: [
          Exercise(
            name: "ex1",
            type: "Cardio"
          )]
    )
  ];
  
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
  }

  // add exercise
  void addExercise(String wName, String type) {
    Workout relevantWorkout = workoutList.firstWhere((workout) => workout.name == wName);

    relevantWorkout.exercises.add(Exercise(name: wName, type: type));

    notifyListeners();
  }

  // check
  void checkOffExercise(String wName, String exName) {
    Exercise relevantExercise = getRelevantExercise(wName, exName);

    relevantExercise.isCompleted = !relevantExercise.isCompleted;
  }

  Workout getRelevantWorkout(String wName) {
    Workout relevantWorkout = workoutList.firstWhere((workout) => workout.name == wName);

    return relevantWorkout;
  }

  Exercise getRelevantExercise(String wName, String exName) {
    Workout relevantWorkout = getRelevantWorkout(wName);

    Exercise relevantExercise =
    relevantWorkout.exercises.firstWhere((exercise) => exercise.name == exName);

    return relevantExercise;
  }
}