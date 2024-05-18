import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'school_search.dart';
import 'setting_display.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _settingState();
}

// ignore: camel_case_types
class _settingState extends State<Setting> {
  late SharedPreferences prefs;

  FocusNode textFocus1 = FocusNode();
  FocusNode textFocus2 = FocusNode();

  String schoolNameInput = '';
  String schoolNumber = '';

  List<bool> selectedtodays = [true, false];

  bool isSchoolName = false;

  String selectedSchoolName = '학교를 입력해주세요';
  String selectedSchoolCity = '지역을 입력해주세요';
  String selectedSchoolNumber = '학번을 입력해주세요';

  Future initPref() async {
    prefs = await SharedPreferences.getInstance();
    final schoolName = prefs.getString('schoolName');
    final schoolCity = prefs.getString('City');
    final schoolNumber = prefs.getString('schoolNumber');

    if (schoolName != null && schoolCity != null) {
      isSchoolName == true;
      selectedSchoolName = schoolName;
      selectedSchoolCity = schoolCity;
    }

    if (schoolNumber != null) {
      selectedSchoolNumber = schoolNumber;
    }
  }

  Future changeIsFirst() async {
    prefs = await SharedPreferences.getInstance();
    final first = prefs.getBool('isFirst');

    if (first == true) {
      setState(() {
        prefs.setBool('isFirst', false);
      });
    }
  }

  Future changeFirstScreen({int isToday = 0}) async {
    prefs = await SharedPreferences.getInstance();
    final todayIsFirst = prefs.getBool('todayIsFirst');

    if (todayIsFirst == null) {
      prefs.setBool('todayIsFirst', true);
    } else {
      if (isToday == 0) {
        if (todayIsFirst == true) {
          setState(() {
            selectedtodays = [true, false];
          });
        } else {
          setState(() {
            selectedtodays = [false, true];
          });
        }
      }
      if (isToday == 1) {
        prefs.setBool('todayIsFirst', true);
      } else if (isToday == 2) {
        prefs.setBool('todayIsFirst', false);
      }
    }
  }

  Future inputSchoolNumber() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('schoolNumber', schoolNumber);
  }

  bool todayIsFirstScreen() {
    if (selectedtodays[0]) {
      return true;
    } else {
      return false;
    }
  }

  bool setBox(selectedSchoolName) {
    bool nameIsShort;
    if (selectedSchoolName.toString().length > 8) {
      nameIsShort = false;
    } else {
      nameIsShort = true;
    }
    return nameIsShort;
  }

  @override
  void initState() {
    super.initState();
    changeFirstScreen();
    initPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 35, 69),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  '설정',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SettingDisplay(
                  // 세팅한거 보여주는 거 나중에 이쁘게 할거임
                  selectedSchoolCity: selectedSchoolCity,
                  selectedSchoolName: selectedSchoolName,
                  selectedSchoolNumber: selectedSchoolNumber,
                  nameIsShort: setBox(selectedSchoolName),
                ),
                const SizedBox(
                  height: 20,
                ),
                schoolSearch(context),
                schoolNumberInput(),
                isTodaySetting(),
                const SizedBox(
                  height: 50,
                ),
                saveButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row saveButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(100, 50),
            backgroundColor: const Color.fromARGB(255, 120, 118, 254),
            shadowColor: Colors.black,
            elevation: 5,
          ),
          child: const Text(
            '저장',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15.0,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            changeIsFirst();
            Navigator.popAndPushNamed(
                context, todayIsFirstScreen() ? 'todayScreen' : 'weekScreen');
          },
        ),
      ],
    );
  }

  Column isTodaySetting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '시작 화면',
          style: TextStyle(
            color: Color.fromARGB(255, 120, 118, 254),
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 75, 75, 101),
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ToggleButtons(
                constraints:
                    BoxConstraints.expand(width: constraints.maxWidth / 2 - 2),
                fillColor: const Color.fromARGB(255, 120, 118, 254),
                selectedColor: Colors.white,
                color: Colors.white,
                onPressed: (int index) {
                  setState(
                    () {
                      for (int i = 0; i < selectedtodays.length; i++) {
                        selectedtodays[i] = i == index;
                      }
                    },
                  );
                  if (selectedtodays[0] == true) {
                    changeFirstScreen(isToday: 1);
                  } else {
                    changeFirstScreen(isToday: 2);
                  }
                },
                isSelected: selectedtodays,
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: const Center(
                      child: Text('오늘의 시간표'),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: const Center(
                      child: Text('이번주 시간표'),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Column schoolNumberInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '학번',
          style: TextStyle(
            color: Color.fromARGB(255, 120, 118, 254),
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 55,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 245, 242, 242),
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(5),
                  FilteringTextInputFormatter.digitsOnly
                ],
                focusNode: textFocus2,
                onChanged: (value) {
                  if (value == '') {
                    schoolNumber = '학번을 입력해주세요';
                  } else {
                    schoolNumber = value;
                  }
                  inputSchoolNumber();
                  setState(() {
                    initPref();
                  });
                },
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '학번 입력',
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 75, 75, 101),
                      fontWeight: FontWeight.w600),
                ),
                onEditingComplete: () {
                  textFocus2.unfocus();
                  inputSchoolNumber();
                  setState(() {
                    initPref();
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Column schoolSearch(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '학교',
          style: TextStyle(
            color: Color.fromARGB(255, 120, 118, 254),
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 10,
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      focusNode: textFocus1,
                      onChanged: (value) {
                        schoolNameInput = value;
                      },
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '학교 이름 입력',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 75, 75, 101),
                            fontWeight: FontWeight.w600),
                      ),
                      onEditingComplete: () {
                        textFocus1.unfocus();
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 120, 118, 254),
                minimumSize: const Size(50, 63),
              ),
              child: const Text(
                '학교 찾기',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                textFocus1.unfocus();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SchoolSearch(
                      input: schoolNameInput,
                    ),
                  ),
                ).then((value) => setState(() {
                      initPref();
                    }));
              },
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
