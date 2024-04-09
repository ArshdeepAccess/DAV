class ServiceModel {
  int sno = 0 ;
  String hsd_detail = "";
  String hsd_pdf_link = "";
  String hsd_sub_type = "";
  String hsd_hdr_dtl = "";

  ServiceModel.fromJson(Map<String, dynamic> json) {
    sno = json['sno'] ?? "";
    hsd_detail = json['hsd_detail'] ?? "";
    hsd_pdf_link = json['hsd_pdf_link'] ?? "";
    hsd_sub_type = json['hsd_sub_type'] ?? "";
    hsd_hdr_dtl = json['hsd_hdr_dtl'] ?? "";
  }
}
