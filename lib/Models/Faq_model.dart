class FaqModel {
  int hsd_sr_no = 0;
  String hsd_detail = "";
  String hsd_pdf_link = "";

  FaqModel.fromJson(Map<String, dynamic> json) {
    hsd_sr_no = json['hsd_sr_no'] ?? "";
    hsd_detail = json['hsd_detail'] ?? "";
    hsd_pdf_link = json['hsd_pdf_link'] ?? "";

  }
}