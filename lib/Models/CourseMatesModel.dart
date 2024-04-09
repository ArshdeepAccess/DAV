class CourseMatesModel {
  String penCategory = "";
  String penServiceNo = "";
  String avName = "";
  String penEmailId = "";
  String penMobNo = "";

  CourseMatesModel.fromJson(Map<String, dynamic> json) {
    penCategory = json['pen_category'] ?? "";
    penServiceNo = json['pen_service_no'].toString() ?? "";
    avName = json['av_name'] ?? "";
    penEmailId = json['pen_email_id'] ?? "";
    penMobNo = json['pen_mob_no'].toString() ?? "";
  }
}
