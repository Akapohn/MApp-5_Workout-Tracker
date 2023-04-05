import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/components/navigator_routes.dart';
import 'package:project/workout_page/workout_data.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await Hive.initFlutter();

  await Hive.openBox("Data1");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => WorkoutData(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: const MaterialColor(
              0xFF000000,
              <int, Color>{
                50: Color(0xFF000000),
                100: Color(0xFF000000),
                200: Color(0xFF000000),
                300: Color(0xFF000000),
                400: Color(0xFF000000),
                500: Color(0xFF000000),
                600: Color(0xFF000000),
                700: Color(0xFF000000),
                800: Color(0xFF000000),
                900: Color(0xFF000000),
              },
            )),
            routes: {
              NavigatorRoutes.routeName: (context) => const NavigatorRoutes()
            }));
  }
}
