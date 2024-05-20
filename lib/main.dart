import 'package:flutter/material.dart';
import 'package:flutter_schedule_app/widgets/setting.dart';

import 'screens/first_screen.dart';
import 'screens/today_screen.dart';
import 'screens/week_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color.fromARGB(255, 36, 35, 69),
        ),
        cardColor: const Color.fromARGB(255, 120, 118, 254),
        hintColor: const Color.fromARGB(255, 75, 75, 101),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        'todayScreen': (context) => const TodayScreen(),
        'weekScreen': (context) => const WeekScreen(),
        'setting': (context) => const Setting(),
      },
      home: const FirstScreen(), //
    );
  }
}
