import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Weekday extends StatefulWidget {
  const Weekday({
    super.key,
  });

  @override
  State<Weekday> createState() => _WeekdayState();
}

class _WeekdayState extends State<Weekday> {
  late SharedPreferences prefs;
  String weekday = '월요일';
  int? check;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    check = prefs.getInt('weekdays');
    if (check == 4) {
      prefs.setInt('weekdays', 0);
      weekday = '금요일';
    } else if (check == 3) {
      prefs.setInt('weekdays', 4);
      weekday = '목요일';
    } else if (check == 2) {
      prefs.setInt('weekdays', 3);
      weekday = '수요일';
    } else if (check == 1) {
      prefs.setInt('weekdays', 2);
      weekday = '화요일';
    } else if (check == 0) {
      prefs.setInt('weekdays', 1);
      weekday = '월요일';
    }
  }

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 5), () {}),
      builder: (BuildContext context, AsyncSnapshot<Null> snapshot) {
        return Container(
          width: 50, // 너비 설정
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(border: Border.all(color: Colors.white)),

          child: Center(
            child: Text(
              weekday,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
