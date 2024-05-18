import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingDisplay extends StatelessWidget {
  const SettingDisplay({
    super.key,
    required this.selectedSchoolCity,
    required this.selectedSchoolName,
    required this.selectedSchoolNumber,
    required this.nameIsShort,
  });

  final String selectedSchoolCity;
  final String selectedSchoolName;
  final String selectedSchoolNumber;
  final bool nameIsShort;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const VerticalDivider(
            indent: 7,
            endIndent: 7,
            color: Colors.white,
            thickness: 1,
            width: 1,
          ),
          Flexible(
            flex: 2,
            child: Column(
              children: [
                const Divider(
                  color: Colors.white,
                ),
                const Text(
                  '지역',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const Divider(
                  color: Colors.white,
                ),
                nameIsShort
                    ? const Text(
                        '학교',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      )
                    : const Column(
                        children: [
                          SizedBox(
                            height: 11,
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
                            height: 10.5,
                          ),
                        ],
                      ),
                const Divider(
                  color: Colors.white,
                ),
                const Text(
                  '학번',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const Divider(
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const VerticalDivider(
            indent: 7,
            endIndent: 7,
            color: Colors.white,
            thickness: 1,
            width: 1,
          ),
          Flexible(
            flex: 4,
            child: Center(
              child: Column(
                children: [
                  const Divider(
                    color: Colors.white,
                  ),
                  Text(
                    selectedSchoolCity,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  Text(
                    selectedSchoolName,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  Text(
                    selectedSchoolNumber,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(
            indent: 7,
            endIndent: 7,
            color: Colors.white,
            thickness: 1,
            width: 1,
          ),
          const Spacer(
            flex: 4,
          ),
        ],
      ),
    );
  }
}
