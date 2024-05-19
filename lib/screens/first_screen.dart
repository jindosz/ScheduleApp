import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/classic_button.dart';
import '../widgets/setting.dart';

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
    // initPrefs();
    //TODO 테스트
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
                      Navigator.pushNamed(
                        context,
                        todayIsFirst ? 'todayScreen' : 'weekScreen',
                      );
                    },
                    child: const ClassicButton(text: '시작하기'),
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
                  Navigator.pushNamed(
                    context,
                    todayIsFirst ? 'todayScreen' : 'weekScreen',
                  );
                },
              );
            },
            child: const ClassicButton(
              text: '기본 설정 시작하기',
            ),
          ),
        ],
      ),
    );
  }
}
