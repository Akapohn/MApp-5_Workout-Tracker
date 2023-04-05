import 'package:flutter/cupertino.dart';
import 'package:project/workout_page/hive_database.dart';
import 'workout.dart';
import 'exercise.dart';
import '../calendar_page/date_time.dart';

class WorkoutData extends ChangeNotifier {
  final db = HiveDatabase();

  List<Workout> workoutList = [
    // Example data
    // List<Workout>[List<Exercise>[List<ExerciseInfo>]]
  ];

  // check first time on app
  void initalizeWorkoutList() {
    if (db.previousDateExists()) {
      workoutList = db.readData();
    } else {
      db.saveData(workoutList);
    }

    loadHeatMap();
  }

  // get the workout list
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  // get length exercise in workout list
  int numberOfExerciseInWorkout(String wName) {
    Workout relevantWorkout = getRelevantWorkout(wName);

    return relevantWorkout.exercises.length;
  }

  String getStartDate(){
    return db.getStartDate();
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

  // Mark that done
  void checkOffExercise(String wName, String exName) {
    Exercise relevantExercise = getRelevantExercise(wName, exName);

    relevantExercise.isCompleted = !relevantExercise.isCompleted;

    notifyListeners();
    db.saveData(workoutList);

    loadHeatMap();
  }

// Get workout name
  Workout getRelevantWorkout(String wName) {
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == wName);

    return relevantWorkout;
  }

// Get exercise name
  Exercise getRelevantExercise(String wName, String exName) {
    Workout relevantWorkout = getRelevantWorkout(wName);

    Exercise relevantExercise = relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exName);

    return relevantExercise;
  }

  int getFalseIndex(String wName) {
    Workout relevantWorkout = getRelevantWorkout(wName);
    int index = 0;
    while (relevantWorkout.exercises[index].isCompleted) {
      index++;
    }
    return index;
  }

  bool allDone(String wName) {
    int index = getFalseIndex(wName);
    if (index >= numberOfExerciseInWorkout(wName)) {
      return true;
    } else {
      return false;
    }
  }

  Map<DateTime, int> heatMapDataSet = {};

  // load heat map
  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(db.getStartDate());

    // count the number of days to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    // go from start date to today and add each completion status to the dataset
    // "COMPLETION_STATUS_yyyymmdd" will be the key in the database
    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd = convertDateTimeToYYYYMMDD(
        startDate.add(Duration(days: i)),
      );

      // completion status = 0 or 1
      int completionStatus = db.getCompletion(yyyymmdd);

      // split the datetime up like below so it doesn't worry about hours/mins/secs etc.

      // year
      int year = startDate.add(Duration(days: i)).year;

      // month
      int month = startDate.add(Duration(days: i)).month;

      // day
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): completionStatus,
      };

      heatMapDataSet.addEntries(percentForEachDay.entries);
      print(heatMapDataSet);
    }
  }

  void editWorkoutName(String currentWorkoutName, String newWorkoutName) {
    Workout workout = getRelevantWorkout(currentWorkoutName);
    workout.name = newWorkoutName;

    notifyListeners();
    // save in database
    db.saveData(workoutList);
  }

  void deleteWorkout(String workoutName) {
    Workout _workout = getRelevantWorkout(workoutName);
    workoutList.remove(_workout);

    notifyListeners();
    // save in database
    db.saveData(workoutList);
  }
}

  

