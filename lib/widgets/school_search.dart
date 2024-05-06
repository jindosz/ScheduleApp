import 'package:flutter/material.dart';
import 'package:flutter_schedule_app/services/api_service.dart';

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
  late Future<List<SchoolInfoModel>> schools;

  @override
  void initState() {
    super.initState();
    schools = ApiService.getSchoolLists(widget.input);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: const Color.fromARGB(255, 24, 6, 131),
        backgroundColor: const Color.fromARGB(255, 24, 6, 131),
        shadowColor: Colors.black,
        elevation: 5,
        title: const Text(
          '학교 검색',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: schools,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //TODO Api 불러와서 표로 만들어주기
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Container();
                  },
                  separatorBuilder: (context, index) => const Divider(
                    height: 10,
                    color: Colors.blue,
                  ),
                );
              } else {
                throw Error();
              }
            },
          ),
        ),
      ),
    );
  }
}
