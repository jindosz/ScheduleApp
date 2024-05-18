import 'package:flutter/material.dart';

class SettingDisplay extends StatelessWidget {
  const SettingDisplay({
    super.key,
    required this.selectedSchoolCity,
    required this.selectedSchoolName,
    required this.selectedSchoolNumber,
  });

  final String selectedSchoolCity;
  final String selectedSchoolName;
  final String selectedSchoolNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Column(
            children: [
              Text(
                '지역',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '학교',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '학번',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Column(
            children: [
              Text(
                selectedSchoolCity,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                selectedSchoolName,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                selectedSchoolNumber,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
