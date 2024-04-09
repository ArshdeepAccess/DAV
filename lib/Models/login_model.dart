class LoginModel {
  int result = 0;
  String pk = "";


  LoginModel.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? "";
    pk = json['pk'] ?? "";

  }
}
