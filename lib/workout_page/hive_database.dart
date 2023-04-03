import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/calendar_page/date_time.dart';
import 'package:project/workout_page/exercise.dart';
import 'workout.dart';

class HiveDatabase {
  final _box = Hive.box("TypeTest7");

  // check, is record start date?
  bool previousDateExists() {
    if (_box.isEmpty) {
      _box.put("START_DATE", todayDate());
      return false;
    } else {
      return true;
    }
  }

  // Start date
  String getStartDate() {
    return _box.get("START_DATE");
  }

  // write data
  void saveData(List<Workout> workouts) {
    final workoutList = convertWorkout(workouts);
    final exerciseList = convertExercise(workouts);

    if (exerciseCompleted(workouts)) {
      _box.put("COMPLETION_${todayDate()}", 1);
    } else {
      _box.put("COMPLETION_${todayDate()}", 0);
    }

    _box.put("WORKOUTS", workoutList);
    _box.put("EXERCISES", exerciseList);
  }

  // read data
  List<Workout> readData() {
    List<Workout> savedWorkouts = [];

    List<dynamic> workoutNames = _box.get("WORKOUTS");
    final exerciseDetails = _box.get("EXERCISES");

    for (int i = 0; i < workoutNames.length; i++) {
      List<Exercise> exercisesInWorkout = [];

      for (int j = 0; j < exerciseDetails[i].length; j++) {
        exercisesInWorkout.add(Exercise(
            name: exerciseDetails[i][j][0],
            type: exerciseDetails[i][j][1],
            time: exerciseDetails[i][j][2],
            weight: exerciseDetails[i][j][3],
            reps: exerciseDetails[i][j][4],
            sets: exerciseDetails[i][j][5],
            isCompleted: exerciseDetails[i][j][6] == "true" ? true : false));
      }

      Workout workout =
          Workout(name: workoutNames[i], exercises: exercisesInWorkout);

      savedWorkouts.add(workout);
    }

    return savedWorkouts;
  }

  // check completion
  bool exerciseCompleted(List<Workout> workouts) {
    for (var workout in workouts) {
      for (var exercise in workout.exercises) {
        if (exercise.isCompleted) {
          return true;
        }
      }
    }
    return false;
  }

  int getCompletion(String yyyymmdd) {
    int complettion = _box.get("COMPLETION_${todayDate()}") ?? 0;
    return complettion;
  }
}

// convert workout object to list
List<dynamic> convertWorkout(List<Workout> workouts) {
  List<dynamic> workoutList = [];

  for (int i = 0; i < workouts.length; i++) {
    workoutList.add(workouts[i].name);
  }

  return workoutList;
}

// convert exercise in workout to list
List<List<List<dynamic>>> convertExercise(List<Workout> workouts) {
  List<List<List<dynamic>>> exerciseList = [];

  for (int i = 0; i < workouts.length; i++) {
    List<Exercise> exerciseInWorkout = workouts[i].exercises;

    List<List<dynamic>> individualWorkout = [];

    for (int j = 0; j < exerciseInWorkout.length; j++) {
      List<dynamic> individualExercise = [];

      individualExercise.addAll([
        exerciseInWorkout[j].name,
        exerciseInWorkout[j].type,
        exerciseInWorkout[j].time,
        exerciseInWorkout[j].weight,
        exerciseInWorkout[j].reps,
        exerciseInWorkout[j].sets,
        exerciseInWorkout[j].isCompleted.toString(),
      ]);

      individualWorkout.add(individualExercise);
    }

    exerciseList.add(individualWorkout);
  }

  return exerciseList;
}
