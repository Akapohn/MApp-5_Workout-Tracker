import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  final String type;
  final String time;
  final String weight;
  final String reps;
  final String sets;
  final bool isCompleted;

  const ExerciseTile(
      {super.key,
      required this.exerciseName,
      required this.type,
      required this.time,
      required this.weight,
      required this.reps,
      required this.sets,
      required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[100],
        child: ListTile(
          title: Text(exerciseName),
          subtitle: Row(
              children: type == "Weight Training"
                  ? [
                      Chip(label: Text(type)),
                      Chip(label: Text("$weight kg")),
                      Chip(label: Text("$reps reps")),
                      Chip(label: Text("$sets sets"))
                    ]
                  : [Chip(label: Text(type)), Chip(label: Text("$time min"))]),
          // leading: const IconButton(
          //   icon: Icon(Icons.edit),
          //   onPressed: null,
          // ),
          trailing: Icon(isCompleted
              ? Icons.check_circle_outline_outlined
              : Icons.circle_outlined),
        ));
  }
}
