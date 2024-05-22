import 'package:flutter/material.dart';
import 'package:flutter_schedule_app/services/api_service.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/drawer_list_view.dart';
import '../widgets/oneline.dart';
import '../widgets/week_schedules.dart';
import '../widgets/weekday.dart';

class WeekScreen extends StatefulWidget {
  const WeekScreen({super.key});

  @override
  State<WeekScreen> createState() => _WeekScreenState();
}

class _WeekScreenState extends State<WeekScreen> {
  late SharedPreferences prefs;
  List perios = ['교시', '1', '2', '3', '4', '5', '6', '7'];
  List weekdays = ['월요일', '화요일', '수요일', '목요일', '금요일'];
  String schoolNumber = '';
  String educationCode = '';
  String schoolCode = '';
  String schoolName = '학교 이름';
  int? check;
  String? weekday;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    schoolNumber = prefs.getString('schoolNumber')!;
    educationCode = prefs.getString('educationCode')!;
    schoolCode = prefs.getString('schoolCode')!;
    schoolName = prefs.getString('schoolName')!;

    setState(() {}); // 학교 이름 Future라 늦게 와서 적용시키는 용도
  }

  List getweekdays() {
    //월화수목금 날짜 받아옴
    List weekdayInstances = [];
    var now = DateTime.now();
    for (int i = 1; i < 6; i++) {
      var firstTime1 =
          DateTime(now.year, now.month, now.day - (now.weekday - i));
      var firstTime2 = firstTime1.toString().replaceAll('-', '');
      weekdayInstances.add(firstTime2.substring(0, 8));
    }
    return weekdayInstances;
  }

  String currentScreen() {
    var name = ModalRoute.of(context)?.settings.name;
    if (name != null) {
      return name;
    } else {
      return '';
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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SliderDrawer(
        sliderOpenSize: 150,
        slideDirection: SlideDirection.RIGHT_TO_LEFT,
        appBar: SliderAppBar(
          drawerIconColor: Theme.of(context).hintColor,
          appBarHeight: 101,
          appBarColor: Theme.of(context).colorScheme.background,
          isTitleCenter: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text('$schoolName의',
                  style: const TextStyle(
                    color: Colors.white,
                  )),
              const Text(
                '이번주 시간표',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        slider: DrawerListView(screen: currentScreen()),
        child: Row(
          children: [
            FutureBuilder(
              // Future를 받아오는 빌더
              future: ApiService.getSchoolSchedules(
                  educationCode: educationCode,
                  schoolCode: schoolCode,
                  dates: getweekdays(),
                  schoolNumber: schoolNumber),
              builder: (context, snapshot) {
                if (snapshot.hasData == false) {
                  return const CircularProgressIndicator(); //정보받을때까지 로딩보여줌
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Error: ${snapshot.error}', // 에러명을 텍스트에 뿌려줌
                      style: const TextStyle(fontSize: 15),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            for (var i in perios)
                              Oneline(
                                perio: i,
                              ),
                          ],
                        ),
                        for (var weekdaycontent in snapshot.data!)
                          Column(
                            children: [
                              const Weekday(),
                              for (var schedule in weekdaycontent)
                                WeekSchedules(
                                  schoolContent: schedule.classContent,
                                )
                            ],
                          )
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
