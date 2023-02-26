import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'workout_display.dart';
import 'Cubit.dart';
import 'workout.dart';

class WorkoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkoutCubit>(
        create: (BuildContext context) {
          WorkoutCubit workoutCubit = WorkoutCubit();
          if (workoutCubit.state.isEmpty) {
            print("----Loading Json-----");
            workoutCubit.getWorkout();
          }
          return workoutCubit;
        },
        child: BlocBuilder<WorkoutCubit, List<Workout>>(
            builder:(context, state) {
              return const WorkoutDisplay();
            }
        )
    );
  }
}