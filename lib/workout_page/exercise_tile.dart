import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  final String type;
  final String time;
  final String weight;
  final String reps;
  final String sets;
  final bool isCompleted;
  void Function(BuildContext)? onDeletePressed;

  ExerciseTile(
      {super.key,
      required this.exerciseName,
      required this.type,
      required this.time,
      required this.weight,
      required this.reps,
      required this.sets,
      required this.isCompleted,
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              // delete option
              SlidableAction(
                onPressed: onDeletePressed,
                backgroundColor: Colors.red.shade400,
                icon: Icons.delete,
                borderRadius: BorderRadius.circular(12),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 20, bottom: 15, left: 10),
            decoration: BoxDecoration(
              color:Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
                title: Text(
                  exerciseName,
                  style: const TextStyle(fontSize: 40),
                ),
                subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: type == "Weight Training"
                        ? [
                            Text(
                              "$weight kg",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "$reps reps",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "$sets sets",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ]
                        : [
                            Text(
                              "$time min",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ]),
                // leading: const IconButton(
                //   icon: Icon(Icons.edit),
                //   onPressed: null,
                // ),
                trailing: Text(
                  type,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              )
          ),
        ),
      ),
    );
  }
}

/*
Icon(isCompleted
              ? Icons.check_circle_outline_outlined
              : Icons.circle_outlined),
*/

/*
ListTile(
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
        )
*/
