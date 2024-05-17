import 'dart:convert';

import 'package:flutter_schedule_app/models/school_schedule_model.dart';
import 'package:http/http.dart' as http;

import '../models/school_info_model.dart';

class ApiService {
  static const String baseUrl = "https://open.neis.go.kr/hub";
  static const String setting = "Type=json&pIndex=1&pSize=100";
  static const String key = "KEY=ff18d1f939d14ed4b63fd660db781aed";

  static Future<List<SchoolInfoModel>> getSchoolLists(String input) async {
    List<SchoolInfoModel> schoolInstances = [];
    final url = Uri.parse('$baseUrl/schoolInfo?$key&$setting&SCHUL_NM=$input');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List schools = [];
      final Map schoolinstances1 = jsonDecode(response.body); //api Map으로 받고
      List schoolinstances2 = schoolinstances1['schoolInfo']; //Map에 있는 List받고
      Map schoolinstances3 = schoolinstances2[1]; //List에 있는 Map받고
      schools = schoolinstances3['row']; //Map에 있는 List받기
      for (var school in schools) {
        schoolInstances.add(SchoolInfoModel.fromJson(school));
      }
      return schoolInstances;
    }
    throw Error();
  }

  static Future<List<SchoolScheduleModel>> getSchoolSchedule(
      {required String educationCode,
      required String schoolCode,
      required String date,
      required String schoolNumber}) async {
    List<SchoolScheduleModel> scheduleInstances = [];
    schoolNumber = '30927'; //TODO 핸드폰에서만 이상함
    var grade = schoolNumber[0];
    var classNumber = schoolNumber.substring(1, 3);
    if (classNumber[0] == '0') {
      classNumber = classNumber[1];
    } // 이새끼 09인식 못해서 09면 9로 바꿔줌
    final url = Uri.parse(
        '$baseUrl/hisTimetable?$key&$setting&ATPT_OFCDC_SC_CODE=$educationCode&SD_SCHUL_CODE=$schoolCode&ALL_TI_YMD=$date&GRADE=$grade&CLASS_NM=$classNumber');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map scheduleInstance1 = jsonDecode(response.body);
      List scheduleInstance2 = scheduleInstance1['hisTimetable'];
      var scheduleInstance3 = scheduleInstance2[1];
      var schedules = scheduleInstance3['row'];
      for (var schedule in schedules) {
        scheduleInstances.add(SchoolScheduleModel.fromJson(schedule));
      }
      return scheduleInstances;
    }
    throw Error();
  }

  static Future<List<dynamic>> getSchoolSchedules(
      {required String educationCode,
      required String schoolCode,
      required List dates,
      required String schoolNumber}) async {
    List weekSchoolScheduleInstances = [];
    for (var date in dates) {
      weekSchoolScheduleInstances.add(
        getSchoolSchedule(
          date: date,
          educationCode: educationCode,
          schoolCode: schoolCode,
          schoolNumber: schoolNumber,
        ),
      );
    }
    return weekSchoolScheduleInstances;
  }
}
