import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/drawer_list_view.dart';

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
        child: Container(),
      ),
    );
  }
}
