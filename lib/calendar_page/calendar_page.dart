import 'package:flutter/material.dart';
import 'package:project/components/heat_map.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../workout_page/workout_data.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPage();
}

class _CalendarPage extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: ((context, value, child) => Scaffold(
            appBar: AppBar(title: const Text("Calendar")),
            body: Center(
                child: MyHeatMap(
              datasets: value.heatMapDataSet,
              startDateYYYYMMDD: value.getStartDate(),
            )),
          )),
    );
  }
}
