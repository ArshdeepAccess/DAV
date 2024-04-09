class EppoModel {
  String name = "";
  String download = "";


  EppoModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    download = json['download'] ?? "";

  }
}
