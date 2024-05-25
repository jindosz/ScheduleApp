import 'package:flutter/material.dart';

class Oneline extends StatelessWidget {
  final String perio;
  const Oneline({
    super.key,
    required this.perio,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
        width: 40, // 너비 설정
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(color: Colors.white)),

        child: Center(
          child: Text(
            perio,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
