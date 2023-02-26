import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Cubit.dart';
import 'workout.dart';

class WorkoutDisplay extends StatelessWidget {
  const WorkoutDisplay({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workout List"),
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.event)),
          IconButton(onPressed: null, icon: Icon(CupertinoIcons.settings))
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<WorkoutCubit, List<Workout>>(
          builder: (context, workouts) => ExpansionPanelList.radio(
              children: workouts.map((workout) => ExpansionPanelRadio(
                value: workout,
                headerBuilder: (BuildContext context, bool isExpanded)=>
                    ListTile(
                      visualDensity: const VisualDensity(
                          horizontal: 0, vertical: VisualDensity.maximumDensity
                      ),
                      leading: const IconButton(onPressed: null, icon: Icon(Icons.edit)),
                      title: Text(workout.title!),
                      onTap: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) =>
                      /** Second screen **/
                      Scaffold(
                          appBar: AppBar(title: Text(workout.title!)),
                          body: ListView.builder(
                              itemCount: workout.exercises.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  ListTile(
                                    onTap: null,
                                    visualDensity: const VisualDensity(
                                        horizontal: 0, vertical: VisualDensity.maximumDensity),
                                    leading: const IconButton(
                                        onPressed: null,
                                        icon: Icon(Icons.edit)),
                                    title: Text(workout.exercises[index].title!),
                                  ))
                      )
                      )),
                    ),
                body: const ElevatedButton(
                  child: Text("Start!"),
                  onPressed: null,
                ),
              )
              ).toList()
          ))),
    );
  }
}