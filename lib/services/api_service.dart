import 'dart:convert';

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
}
