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
    return IntrinsicHeight(
      child: Row(
        children: [
          const Spacer(
            flex: 1,
          ),
          const Flexible(
            flex: 1,
            child: Center(
              child: Column(
                children: [
                  Text(
                    '지역',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '학교',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '학번',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(
            width: 2,
            color: Colors.black,
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: Column(
                children: [
                  Text(
                    selectedSchoolCity,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    selectedSchoolName,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    selectedSchoolNumber,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
