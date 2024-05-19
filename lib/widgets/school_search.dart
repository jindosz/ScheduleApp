import 'package:flutter/material.dart';
import 'package:flutter_schedule_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/school_info_model.dart';

class SchoolSearch extends StatefulWidget {
  final String? schoolName, city;
  final String input;

  const SchoolSearch({
    super.key,
    this.schoolName,
    this.city,
    required this.input,
  });

  @override
  State<SchoolSearch> createState() => _SchoolSearchState();
}

class _SchoolSearchState extends State<SchoolSearch> {
  late SharedPreferences prefs;

  Future savingSchoolInfo({
    required String schoolName,
    required String schoolCity,
    required String officeOfEducation,
    required String educationCode,
    required String schoolCode,
  }) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('schoolName', schoolName);
    prefs.setString('City', schoolCity);
    prefs.setString('officeOfEducation', officeOfEducation);
    prefs.setString('educationCode', educationCode);
    prefs.setString('schoolCode', schoolCode);
  } // 학교 검색한거 저장

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 35, 69),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: ApiService.getSchoolLists(widget.input),
            builder: (context, snapshot) {
              if (snapshot.hasData == false) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: CircularProgressIndicator(),
                  ),
                );
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
                    const SizedBox(
                      height: 10,
                    ),
                    makeList(snapshot),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  makeList(AsyncSnapshot<List<SchoolInfoModel>> snapshot) {
    //표처럼 띄우는거
    return Center(
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                const Spacer(
                  flex: 1,
                ),
                Flexible(
                  flex: 3,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: const Text(
                        '지역',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                const VerticalDivider(
                  color: Color.fromARGB(255, 75, 75, 101),
                  width: 2,
                  thickness: 1,
                ),
                const Spacer(
                  flex: 1,
                ),
                Flexible(
                  flex: 6,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: const Text(
                        '학교명',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
          ),
          const Divider(
            height: 2,
            thickness: 1,
            color: Color.fromARGB(255, 75, 75, 101),
          ),
          for (var school in snapshot.data!)
            if (school.level == '고등학교')
              Column(
                children: [
                  Row(
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      Flexible(
                        flex: 3,
                        child: Center(
                          child: SizedBox(
                            child: Text(
                              school.city,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 75, 75, 101),
                        ),
                        width: 1,
                        height: 50,
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Flexible(
                        flex: 6,
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              savingSchoolInfo(
                                schoolName: school.schoolName,
                                schoolCity: school.city,
                                officeOfEducation: school.officeOfEducation,
                                educationCode: school.educationCode,
                                schoolCode: school.schoolCode,
                              );
                              Navigator.pop(context, '${widget.schoolName}');
                            },
                            child: SizedBox(
                              child: Text(
                                school.schoolName,
                                style: TextStyle(
                                    color: Colors.blue[700],
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                  const Divider(
                    height: 1,
                    color: Color.fromARGB(255, 75, 75, 101),
                  ),
                ],
              ),
        ],
      ),
    );
  }
}
