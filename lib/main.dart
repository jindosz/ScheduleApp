import 'package:flutter/material.dart';

import 'screens/first_screen.dart';
import 'screens/today_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//TODO 임시로 바꿔둠 first로 다시 바꿀것
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FirstScreen(), //
    );
  }
}
