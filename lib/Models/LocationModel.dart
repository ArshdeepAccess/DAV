class LocationModel {
  String locationDesc = "";
  String latitude = "";
  String longitude = "";
  double distance = 0;

  LocationModel.fromJson(Map<String, dynamic> json) {
    locationDesc = json['location_desc']  ;
    latitude = json['latitude']   ;
    longitude = json['longitude'] ;
  }
}