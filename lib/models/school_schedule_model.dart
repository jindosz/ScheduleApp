class SchoolScheduleModel {
  final String perio, classContent;

  SchoolScheduleModel.fromJson(Map<String, dynamic> json)
      : perio = json['PERIO'],
        classContent = json['ITRT_CNTNT'];
}
