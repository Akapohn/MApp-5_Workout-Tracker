import 'package:flutter/material.dart';
import 'package:project/workout_page/workout_data.dart';
import 'package:provider/provider.dart';

class StartExercise extends StatefulWidget {
  final String workoutName;
  const StartExercise({super.key, required this.workoutName});

  @override
  State<StatefulWidget> createState() => _StartExercise();
}

class _StartExercise extends State<StartExercise> {
  int exerciseIndex = 0;

  void increaseIndex() {
    setState(() {
      exerciseIndex++;
    });
  }

  void decreaseIndex() {
    setState(() {
      exerciseIndex--;
    });
  }

  // void markCompletion(WorkoutData value) {
  //   if ()
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
        builder: (context, value, child) => Scaffold(
              body: Container(
                  alignment: Alignment.center,
                  // Workout contents
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: value
                                  .getRelevantWorkout(widget.workoutName)
                                  .exercises[exerciseIndex]
                                  .type ==
                              "Weight Training"
                          ?
                          // Weight Trainin Content
                          [
                              // Type
                              Container(
                                  margin: const EdgeInsets.only(bottom: 30),
                                  child: Text(
                                      value
                                          .getRelevantWorkout(
                                              widget.workoutName)
                                          .exercises[exerciseIndex]
                                          .type,
                                      style: const TextStyle(
                                          fontSize: 25,
                                      ))),
                              // Name
                              Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                      value
                                          .getRelevantWorkout(
                                              widget.workoutName)
                                          .exercises[exerciseIndex]
                                          .name,
                                      style: const TextStyle(fontSize: 50,fontWeight: FontWeight.bold))),
                              // Content
                              Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 100, left: 50, right: 50),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Reps
                                        Text(
                                            "${value.getRelevantWorkout(widget.workoutName).exercises[exerciseIndex].reps} reps",
                                            style: const TextStyle(
                                                fontSize: 40,
                                            )),
                                        // Sets
                                        Text(
                                            "${value.getRelevantWorkout(widget.workoutName).exercises[exerciseIndex].sets} Sets",
                                            style: const TextStyle(
                                                fontSize: 40,
                                            ))
                                      ])),
                              // Weight
                              Container(
                                  margin: const EdgeInsets.only(bottom: 200),
                                  child: Text(
                                      "${value.getRelevantWorkout(widget.workoutName).exercises[exerciseIndex].weight} kg",
                                      style: const TextStyle(fontSize: 60,fontWeight: FontWeight.bold))),
                            ]
                          : // Cardio Content
                          [
                              // Type
                              Container(
                                  margin: const EdgeInsets.only(
                                      top: 100, bottom: 30),
                                  child: Text(
                                      value
                                          .getRelevantWorkout(
                                              widget.workoutName)
                                          .exercises[exerciseIndex]
                                          .type,
                                      style: const TextStyle(
                                          fontSize: 25,
                                      ))),
                              // Name
                              Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                      value
                                          .getRelevantWorkout(
                                              widget.workoutName)
                                          .exercises[exerciseIndex]
                                          .name,
<<<<<<< Updated upstream
                                      style: const TextStyle(fontSize: 40)))
=======
                                      style: const TextStyle(fontSize: 50,fontWeight: FontWeight.bold))),
                              CardioCountdown(
                                  time: int.parse(value
                                      .getRelevantWorkout(widget.workoutName)
                                      .exercises[exerciseIndex]
                                      .time))
>>>>>>> Stashed changes
                            ])),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back btn
                  IconButton(
                      onPressed: exerciseIndex <= 0
                          ? null
                          : () {
                              decreaseIndex();
                              value.checkOffExercise(
                                  widget.workoutName,
                                  value
                                      .getRelevantWorkout(widget.workoutName)
                                      .exercises[exerciseIndex]
                                      .name);
                            },
                      icon: const Icon(Icons.keyboard_arrow_left)),
                  // Finish workout
                  exerciseIndex >=
                          (value.numberOfExerciseInWorkout(widget.workoutName) -
                              1)
                      ? ElevatedButton(
                          onPressed: () {
                            value.checkOffExercise(
                                widget.workoutName,
                                value
                                    .getRelevantWorkout(widget.workoutName)
                                    .exercises[exerciseIndex]
                                    .name);
                            Navigator.of(context)
                                .popUntil(ModalRoute.withName("/ExercisePage"));
                          },
                          child: const Text("Done"))
                      : ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .popUntil(ModalRoute.withName("/ExercisePage"));
                          },
                          child: const Text("Pause")),
                  // Next btn
                  IconButton(
                      onPressed: exerciseIndex >=
                              (value.numberOfExerciseInWorkout(
                                      widget.workoutName) -
                                  1)
                          ? null
                          : () {
                              value.checkOffExercise(
                                  widget.workoutName,
                                  value
                                      .getRelevantWorkout(widget.workoutName)
                                      .exercises[exerciseIndex]
                                      .name);
                              increaseIndex();
                            },
                      icon: const Icon(Icons.keyboard_arrow_right))
                ],
              ),
            ));
  }
}
