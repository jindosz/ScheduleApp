import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  @override
  void initState() {
    super.initState();
    changeFirstScreen();
    initPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              schoolSearch(context),
              const SizedBox(
                height: 20,
              ),
              schoolNumberInput(),
              const SizedBox(
                height: 20,
              ),
              isTodaySetting(),
              const SizedBox(
                height: 50,
              ),
              SettingDisplay(
                  // 세팅한거 보여주는 거 나중에 이쁘게 할거임
                  selectedSchoolCity: selectedSchoolCity,
                  selectedSchoolName: selectedSchoolName,
                  selectedSchoolNumber: selectedSchoolNumber),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 50),
                  backgroundColor: Colors.lightBlue,
                  shadowColor: Colors.black,
                  elevation: 5,
                ),
                child: const Text(
                  '확인',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  changeIsFirst();
                  Navigator.popAndPushNamed(context,
                      todayIsFirstScreen() ? 'todayScreen' : 'weekScreen');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ToggleButtons isTodaySetting() {
    return ToggleButtons(
      fillColor: Colors.lightBlue,
      selectedColor: Colors.white,
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
        Radius.circular(8),
      ),
      children: const [
        SizedBox(
          width: 157,
          height: 20,
          child: Center(
            child: Text('오늘의 시간표'),
          ),
        ),
        SizedBox(
          width: 157,
          height: 20,
          child: Center(
            child: Text('이번주 시간표'),
          ),
        ),
      ],
    );
  }

  Container schoolNumberInput() {
    return Container(
      width: 315,
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
    );
  }

  Row schoolSearch(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200,
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
                focusNode: textFocus1,
                onChanged: (value) {
                  schoolNameInput = value;
                },
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '학교 이름 입력',
                ),
                onEditingComplete: () {
                  textFocus1.unfocus();
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(20, 55),
            backgroundColor: const Color.fromARGB(255, 98, 0, 255),
            shadowColor: Colors.black,
            elevation: 5,
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
    );
  }
}
