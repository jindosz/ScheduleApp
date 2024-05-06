import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/school_info_model.dart';

class ApiService {
  static const String baseUrl = "https://open.neis.go.kr/hub";
  static const String setting = "Type=json&pIndex=1&pSize=100";
  static const String key = "KEY=ff18d1f939d14ed4b63fd660db781aed";

  static Future<List<SchoolInfoModel>> getSchoolLists(String input) async {
    List<SchoolInfoModel> schoolInstances = [];
    final url = Uri.parse('$baseUrl//schoolInfo?$key&$setting&$input');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> schools = jsonDecode(response.body);
      for (var school in schools) {
        schoolInstances.add(SchoolInfoModel.fromJson(school));
      }
      return schoolInstances;
    }
    throw Error();
  }
}
