import 'package:flutter/material.dart';

class WeekScreen extends StatelessWidget {
  const WeekScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: const Color.fromARGB(255, 24, 6, 131),
        backgroundColor: const Color.fromARGB(255, 24, 6, 131),
        shadowColor: Colors.black,
        elevation: 5,
        title: const Center(
          child: Text(
            '이번주 시간표',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(),
    );
  }
}
