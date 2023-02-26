import 'package:equatable/equatable.dart';
import 'package:project/workout_page/exercises.dart';

class Workout extends Equatable{
  final String? title;
  final List<Exercise> exercises;
  const Workout({required this.exercises, required this.title, });

  factory Workout.fromJson(Map<String, dynamic> json) {
    List<Exercise> exercises = [];
    int index = 0;
    for (var ex in (json['exercises'] as Iterable)) {
      exercises.add(Exercise.fromJson(ex, index));
      index++;
      print("-----$index------");
    }
    return Workout(title: json['title'] as String?, exercises: exercises);
  }
  Map<String, dynamic> toJson() => {'title': title, 'exercises': exercises};

  @override
  List<Object?> get props => [title, exercises];

  @override
  bool get stringify => true;
}