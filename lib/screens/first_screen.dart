import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/setting.dart';
import 'today_screen.dart';
import 'week_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late SharedPreferences prefs;

  bool isFirst = true;
  bool todayIsFirst = true;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final first = prefs.getBool('isFirst');
    final todayScreenIsFirst = prefs.getBool('todayIsFirst');

    if (first == false) {
      // 이 앱에 처음 접속 아니면
      setState(() {
        //이거하는데
        isFirst = false; // 밖에 나 처음 아님 알림
        if (todayScreenIsFirst != null) {
          // null 방지용
          todayIsFirst = todayScreenIsFirst; // 오늘 시간표인지 아닌지 알림
        }
      });
    } else {
      prefs.setBool('isFirst', true); // 이 앱 첨이면 첨이라고 알려줌
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
      body: isFirst
          ? settingStartButton(context)
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => todayIsFirst
                              ? const TodayScreen()
                              : const WeekScreen(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 98, 0, 255),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(2, 3),
                          )
                        ],
                      ),
                      width: 200,
                      height: 50,
                      child: const Center(
                        child: Text(
                          '시작하기',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Center settingStartButton(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Setting(),
                ),
              ).then(
                (value) {
                  initPrefs();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => todayIsFirst
                          ? const TodayScreen()
                          : const WeekScreen(),
                    ),
                  );
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 98, 0, 255),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(2, 3),
                  )
                ],
              ),
              width: 200,
              height: 50,
              child: const Center(
                child: Text(
                  '초기 설정 시작하기',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
