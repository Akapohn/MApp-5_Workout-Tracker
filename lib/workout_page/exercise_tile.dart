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
          title: Text(
            exerciseName,
            style: TextStyle(fontSize: 40),
          ),
          subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: type == "Weight Training"
                  ? [
                      Text(
                        "$weight kg",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "$reps reps",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "$sets sets",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ]
                  : [Text("$time min",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)]),
          // leading: const IconButton(
          //   icon: Icon(Icons.edit),
          //   onPressed: null,
          // ),
          trailing: Text(
            type,
            style: TextStyle(fontSize: 20,),
          ),
        ));
  }
}

/*
Icon(isCompleted
              ? Icons.check_circle_outline_outlined
              : Icons.circle_outlined),
*/