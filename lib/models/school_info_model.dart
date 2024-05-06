class SchoolInfoModel {
  final String officeOfEducation, schoolName, city;

  SchoolInfoModel.fromJson(Map<String, dynamic> json)
      : officeOfEducation = json['ATPT_OFCDC_SC_NM'],
        schoolName = json['SCHUL_NM'],
        city = json['LCTN_SC_NM'];
}
