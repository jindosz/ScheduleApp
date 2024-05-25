import 'package:flutter/material.dart';

class WeekSchedules extends StatelessWidget {
  final String schoolContent;

  const WeekSchedules({
    super.key,
    required this.schoolContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60, // 너비 설정
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(border: Border.all(color: Colors.white)),

      child: Center(
        child: Text(
          schoolContent,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
