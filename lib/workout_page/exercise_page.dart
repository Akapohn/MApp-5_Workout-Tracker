import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/workout_page/exercise_tile.dart';
import 'package:project/workout_page/start_exercise.dart';
import 'package:project/workout_page/workout_data.dart';
import 'package:provider/provider.dart';

class ExercisePage extends StatefulWidget {
  final String workoutName;
  const ExercisePage({super.key, required this.workoutName});

  @override
  State<ExercisePage> createState() => _ExercisePage();
}

class _ExercisePage extends State<ExercisePage> {
  final _formKey = GlobalKey<FormState>();
  final exerciseNameController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController repsController = TextEditingController();
  final TextEditingController setsController = TextEditingController();
  bool weightTraining = false;
  bool cardio = false;
  bool canStart = true;

  Future<void> createNewExercise(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                title: const Text("Add a new exercise"),
                content: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: exerciseNameController,
                          validator: (value) {
                            return value!.isNotEmpty ? null : "Invalid Field";
                          },
                          decoration: const InputDecoration(
                              hintText: "Enter the exercise name"),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ActionChip(
                                backgroundColor:
                                    weightTraining ? Colors.green : null,
                                label: const Text("Weight Training"),
                                onPressed: () {
                                  setState(() {
                                    weightTraining = !weightTraining;
                                  });
                                }),
                            ActionChip(
                                backgroundColor: cardio ? Colors.green : null,
                                label: const Text("Cardio"),
                                onPressed: () {
                                  setState(() {
                                    cardio = !cardio;
                                  });
                                })
                          ],
                        ),
                        Column(
                            children: weightTraining && !cardio
                                ? // Weight training input
                                [
                                    // Weight
                                    TextFormField(
                                      controller: weightController,
                                      validator: (value) {
                                        return value!.isNotEmpty
                                            ? null
                                            : "Invalid Field";
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Weight (kg)"),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                    // Reps
                                    TextFormField(
                                      controller: repsController,
                                      validator: (value) {
                                        return value!.isNotEmpty
                                            ? null
                                            : "Invalid Field";
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Reps"),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                    // Sets
                                    TextFormField(
                                      controller: setsController,
                                      validator: (value) {
                                        return value!.isNotEmpty
                                            ? null
                                            : "Invalid Field";
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Sets"),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    )
                                  ]
                                : cardio && !weightTraining
                                    ? // Cardio input
                                    [
                                        // Time
                                        TextFormField(
                                          controller: timeController,
                                          validator: (value) {
                                            return value!.isNotEmpty
                                                ? null
                                                : "Invalid Field";
                                          },
                                          decoration: const InputDecoration(
                                              hintText: "Time (min)"),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                        )
                                      ]
                                    : [])
                      ],
                    )),
                actions: [
                  // Cancel btn
                  MaterialButton(
                    onPressed: cancel,
                    child: const Text("Cancel"),
                  ),
                  // Save btn
                  MaterialButton(
                    onPressed: () {
                      if ((weightTraining && cardio) ||
                          (!weightTraining && !cardio)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Choose one type')));
                      }
                      if (_formKey.currentState!.validate()) {
                        save();
                      }
                    },
                    child: const Text("Save"),
                  )
                ]);
          });
        });
  }

  void save() {
    String newExerciseName = exerciseNameController.text;
    String nType = weightTraining && !cardio ? "Weight Training" : "Cardio";
    String nTime = timeController.text;
    String nWeight = weightController.text;
    String nReps = repsController.text;
    String nSets = setsController.text;
    Provider.of<WorkoutData>(context, listen: false).addExercise(
        widget.workoutName,
        newExerciseName,
        nType,
        cardio ? nTime : '',
        nWeight,
        nReps,
        nSets);
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    exerciseNameController.clear();
    timeController.clear();
    weightController.clear();
    repsController.clear();
    setsController.clear();
    weightTraining = false;
    cardio = false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
        builder: (context, value, child) => Scaffold(
            appBar: AppBar(title: Text(widget.workoutName), actions: [
              IconButton(
                  onPressed: () async {
                    await createNewExercise(context);
                  },
                  icon: const Icon(Icons.add))
            ]),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50)),
                  // Press Start Btn
                  onPressed: canStart
                      ? () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              StartExercise(workoutName: widget.workoutName)))
                      : null,
                  child: const Text(
                    "Start",
                    style: TextStyle(fontSize: 30),
                  ),
                )),
            body: ListView.builder(
                itemCount: value.numberOfExerciseInWorkout(widget.workoutName),
                itemBuilder: (context, index) => ExerciseTile(
                    exerciseName: value
                        .getRelevantWorkout(widget.workoutName)
                        .exercises[index]
                        .name,
                    type: value
                        .getRelevantWorkout(widget.workoutName)
                        .exercises[index]
                        .type,
                    time: value
                        .getRelevantWorkout(widget.workoutName)
                        .exercises[index]
                        .time,
                    weight: value
                        .getRelevantWorkout(widget.workoutName)
                        .exercises[index]
                        .weight,
                    reps: value
                        .getRelevantWorkout(widget.workoutName)
                        .exercises[index]
                        .reps,
                    sets: value
                        .getRelevantWorkout(widget.workoutName)
                        .exercises[index]
                        .sets,
                    isCompleted: value
                        .getRelevantWorkout(widget.workoutName)
                        .exercises[index]
                        .isCompleted))));
  }
}
