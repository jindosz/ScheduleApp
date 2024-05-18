import 'package:flutter/material.dart';
import 'package:flutter_schedule_app/widgets/setting.dart';

import 'screens/first_screen.dart';
import 'screens/today_screen.dart';
import 'screens/week_screen.dart';
import 'widgets/school_search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
