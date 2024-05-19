import 'package:flutter/material.dart';
import 'package:flutter_schedule_app/services/api_service.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/drawer_list_view.dart';
import '../widgets/week_schedules.dart';

class WeekScreen extends StatefulWidget {
  const WeekScreen({super.key});

  @override
  State<WeekScreen> createState() => _WeekScreenState();
}

class _WeekScreenState extends State<WeekScreen> {
  @override
  Widget build(BuildContext context) {
    late SharedPreferences prefs;
    String schoolNumber = '';
    String educationCode = '';
    String schoolCode = '';
    String schoolName = '학교 이름';

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

    @override
    void initState() {
      super.initState();
      initPrefs();
    }
    //TODO push되고 초기설정 발동되게하기

    return Scaffold(
      backgroundColor: Colors.white,
      body: SliderDrawer(
        sliderOpenSize: 150,
        slideDirection: SlideDirection.RIGHT_TO_LEFT,
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
                '이번주 시간표',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        slider: const DrawerListView(),
        child: Row(
          children: [
            Column(
              children: [Container()],
            ),
            FutureBuilder(
              // Future를 받아오는 빌더
              future: ApiService.getSchoolSchedules(
                  // 받아옴
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
                  return WeekSchedules(
                    snapshot: snapshot.data!,
                  ); // 여기다 꾸미면됨
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
