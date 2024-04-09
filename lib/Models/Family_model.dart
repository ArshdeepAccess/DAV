class FamilyModel {
  int hsd_sr_no = 0;
  String hsd_detail = "";
  String hsd_pdf_link = "";
  String hsd_sub_type = "";
  String hsd_hdr_dtl = "";

  FamilyModel.fromJson(Map<String, dynamic> json) {
    hsd_sr_no = json['hsd_sr_no'] ?? "";
    hsd_detail = json['hsd_detail'] ?? "";
    hsd_pdf_link = json['hsd_pdf_link'] ?? "";
    hsd_sub_type = json['hsd_sub_type'] ?? "";
    hsd_hdr_dtl = json['hsd_hdr_dtl'] ?? "";
  }
}
