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
//TODO 임시로 바꿔둠 first로 다시 바꿀것
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'todayScreen': (context) => const TodayScreen(),
        'weekScreen': (context) => const WeekScreen(),
        'setting': (context) => const Setting(),
      },
      home: const FirstScreen(), //
    );
  }
}
