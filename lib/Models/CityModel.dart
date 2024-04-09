// class CountryModel {
//   String d = "";
//   int r = 0;
//
//   CountryModel.fromJson(Map<String, dynamic> json) {
//     d = json['d'];
//     r = json['r'];
//   }
// }
//
class CountryModel {
  String city_name = "";
  String city_code = "";

  CountryModel.fromJson(Map<String, dynamic> json) {
    city_name = json['city_name']  ?? "";
    city_code = json['city_code']  ?? "";
  }
}
