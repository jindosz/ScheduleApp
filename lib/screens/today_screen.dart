import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/school_search.dart';

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
    final bool? todayIsFirst = prefs.getBool('todayIsFirst');
    if (todayIsFirst != null) {
      isFirst = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    String schoolNameInput = '';

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: const Color.fromARGB(255, 24, 6, 131),
          backgroundColor: const Color.fromARGB(255, 24, 6, 131),
          shadowColor: Colors.black,
          elevation: 5,
          title: const Center(
            child: Text(
              '설정',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: isFirst
            ? Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 245, 242, 242),
                            border: Border.all(),
                          ),
                          child: Center(
                            child: TextField(
                              onSubmitted: (value) {
                                schoolNameInput = value;
                                print(schoolNameInput);
                              },
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                hintText: '학교 이름 입력',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(10, 40),
                            backgroundColor: Colors.white,
                            shadowColor: Colors.black,
                            elevation: 5,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                          child: const Text('학교 찾기'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SchoolSearch(
                                  input: schoolNameInput,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            : const Column());
  }
}
