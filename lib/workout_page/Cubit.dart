import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:project/workout_page/workout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutCubit extends Cubit<List<Workout>> {
  WorkoutCubit(): super([]);
  
  getWorkout() async {
    final List<Workout> workouts = [];
    
    final workoutJson = jsonDecode(await rootBundle.loadString("assets/workouts.json"));
    for(var el in (workoutJson as Iterable)) {
      workouts.add(Workout.fromJson(el));
    }
    emit(workouts);
  }
}