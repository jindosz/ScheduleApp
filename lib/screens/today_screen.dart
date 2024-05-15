import 'package:flutter/material.dart';
import 'package:flutter_schedule_app/services/api_service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/drawer_list_view.dart';
import '../widgets/peroid_schoolcontent.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  late SharedPreferences prefs;
  String schoolNumber = '';
  String educationCode = '';
  String schoolCode = '';
  String schoolName = '학교 이름';
  List? todaySchedules;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    schoolNumber = prefs.getString('schoolNumber')!;
    educationCode = prefs.getString('educationCode')!;
    schoolCode = prefs.getString('schoolCode')!;
    schoolName = prefs.getString('schoolName')!;

    setState(() {}); // 학교 이름 Future라 늦게 와서 적용시키는 용도
  }

  String getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    var strToday = formatter.format(now);
    var result = strToday.replaceAll('-', '');
    return result;
  }

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: SliderDrawer(
        appBar: SliderAppBar(
          appBarHeight: 101,
          appBarColor: Colors.yellow[100]!,
          isTitleCenter: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text('$schoolName의'),
              const Text(
                '오늘의 시간표',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        sliderOpenSize: 150,
        slideDirection: SlideDirection.RIGHT_TO_LEFT,
        slider: const DrawerListView(),
        child: Container(
          color: Colors.yellow[100],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                FutureBuilder(
                  future: ApiService.getSchoolSchedule(
                    date: getToday(),
                    educationCode: educationCode,
                    schoolCode: schoolCode,
                    schoolNumber: schoolNumber,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData == false) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Error: ${snapshot.error}', // 에러명을 텍스트에 뿌려줌
                          style: const TextStyle(fontSize: 15),
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          for (var schedule in snapshot.data!)
                            PeroidAndClassContentBox(
                              peroid: schedule.perio,
                              schoolContent: schedule.classContent,
                            ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
