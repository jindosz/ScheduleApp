import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  late SharedPreferences prefs;
  bool isFirst = true;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final first = prefs.getBool('isFirst');
    if (first == false) {
      setState(() {
        isFirst = false;
      });
    } else {
      prefs.setBool('isFirst', true);
    }
  }

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

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
            '오늘의 시간표',
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
