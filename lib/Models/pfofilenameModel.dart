class ProfilenameModel {
  String user_service_no = "";
  String user_chk_suffix = "";
  String user_pan_no = "";
  int user_aadhar_no = 0;
  String user_dob = "";
  String user_doc = "";
  String user_dod = "";
  String user_email_id = "";
  int user_mob_no = 0;
  String av_name = "";
  String private_status = "";

  ProfilenameModel.fromJson(Map<String, dynamic> json) {
    user_service_no = json['user_service_no'] ?? "";
    user_chk_suffix = json['user_chk_suffix'] ?? "";
    user_pan_no = json['user_pan_no'] ?? "";
    user_aadhar_no = json['user_aadhar_no'] ?? "";
    user_dob = json['user_dob'] ?? "";
    user_doc = json['user_doc'] ?? "";
    user_dod = json['user_dod'] ?? "";
    user_email_id = json['user_email_id'] ?? "";
    user_mob_no = json['user_mob_no'] ?? "";
    av_name = json['av_name'] ?? "";
    private_status = json['private_status'] ?? "";
  }
}
