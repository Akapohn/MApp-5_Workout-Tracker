import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/components/navigator_routes.dart';
import 'package:project/workout_page/workout_data.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await Hive.initFlutter();

  await Hive.openBox("TypeTest7");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => WorkoutData(),
        child: MaterialApp(debugShowCheckedModeBanner: false, routes: {
          NavigatorRoutes.routeName: (context) => const NavigatorRoutes()
        }));
  }
}
