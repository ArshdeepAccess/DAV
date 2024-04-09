// class PorModel {
//   int rownum = 0;
//   int por_year = 0;
//   int por_no = 0;
//   String pordate="";
//   String por_type_desc="";
//   String download = "";
//   String por_service_no = "";
//   String add1_a = "";
//   String add2_a = "";
//   String add3_a = "";
//   String state_a= "";
//    String pincode_a = "";
//
//
//   PorModel.fromJson(Map<String, dynamic> json) {
//     rownum = json['rownum'] ?? "";
//     por_year = json['por_year'] ?? "";
//     por_no = json['por_no'] ?? "";
//     pordate=json['pordate'] ?? "";
//     por_type_desc=json['por_type_desc'] ?? "";
//     download = json['download'] ?? "";
//     por_service_no = json['por_service_no'] ?? "";
//     add1_a  = json['add1_a'] ?? "";
//     add2_a = json['add2_a'] ?? "";
//     add3_a = json['add3_a'] ?? "";
//     state_a= json['state_a'] ?? "";
//     pincode_a = json['pincode_a'] ?? "";
//
//   }
// }

class PorModel {
  int? rownum;
  int? porNo;
  String? porDate;
  String? pordate;
  String? porType;
  int? porYear;
  String? porTypeDesc;
  String? porServiceNo;
  String? link;
  String? porRemarkAuth;
  int? porOccuranceNo;
  // Null? porCancelRef;
  // Null? porCancelRemarks;
  // Null? porCancelBy;
  String? add1A;
  String? add2A;
  String? add3A;
  String? stateA;
  int? pincodeA;
  String? wefDateA;
  String? childNameB;
  String? pobB;
  String? dobB;
  String? sexB;
  // Null? nameC;
  // Null? newNameC;
  // Null? relationC;
  String? wefC;
  // Null? download;

  PorModel(
      {this.rownum,
        this.porNo,
        this.porDate,
        this.pordate,
        this.porType,
        this.porYear,
        this.porTypeDesc,
        this.porServiceNo,
        this.link,
        this.porRemarkAuth,
        this.porOccuranceNo,
        // this.porCancelRef,
        // this.porCancelRemarks,
        // this.porCancelBy,
        this.add1A,
        this.add2A,
        this.add3A,
        this.stateA,
        this.pincodeA,
        this.wefDateA,
        this.childNameB,
        this.pobB,
        this.dobB,
        this.sexB,
        // this.nameC,
        // this.newNameC,
        // this.relationC,
        this.wefC,
        // this.download
      });

  PorModel.fromJson(Map<String, dynamic> json) {
    rownum = json['rownum'];
    porNo = json['por_no'];
    porDate = json['por_date'];
    pordate = json['pordate'];
    porType = json['por_type'];
    porYear = json['por_year'];
    porTypeDesc = json['por_type_desc'];
    porServiceNo = json['por_service_no'];
    link = json['link'];
    porRemarkAuth = json['por_remark_auth'];
    porOccuranceNo = json['por_occurance_no'];
    // porCancelRef = json['por_cancel_ref'];
    // porCancelRemarks = json['por_cancel_remarks'];
    // porCancelBy = json['por_cancel_by'];
    add1A = json['add1_a'];
    add2A = json['add2_a'];
    add3A = json['add3_a'];
    stateA = json['state_a'];
    pincodeA = json['pincode_a'];
    wefDateA = json['wef_date_a'];
    childNameB = json['child_name_b'];
    pobB = json['pob_b'];
    dobB = json['dob_b'];
    sexB = json['sex_b'];
    // nameC = json['name_c'];
    // newNameC = json['new_name_c'];
    // relationC = json['relation_c'];
    wefC = json['wef_c'];
    // download = json['download'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rownum'] = this.rownum;
    data['por_no'] = this.porNo;
    data['por_date'] = this.porDate;
    data['pordate'] = this.pordate;
    data['por_type'] = this.porType;
    data['por_year'] = this.porYear;
    data['por_type_desc'] = this.porTypeDesc;
    data['por_service_no'] = this.porServiceNo;
    data['link'] = this.link;
    data['por_remark_auth'] = this.porRemarkAuth;
    data['por_occurance_no'] = this.porOccuranceNo;
    // data['por_cancel_ref'] = this.porCancelRef;
    // data['por_cancel_remarks'] = this.porCancelRemarks;
    // data['por_cancel_by'] = this.porCancelBy;
    data['add1_a'] = this.add1A;
    data['add2_a'] = this.add2A;
    data['add3_a'] = this.add3A;
    data['state_a'] = this.stateA;
    data['pincode_a'] = this.pincodeA;
    data['wef_date_a'] = this.wefDateA;
    data['child_name_b'] = this.childNameB;
    data['pob_b'] = this.pobB;
    data['dob_b'] = this.dobB;
    data['sex_b'] = this.sexB;
    // data['name_c'] = this.nameC;
    // data['new_name_c'] = this.newNameC;
    // data['relation_c'] = this.relationC;
    data['wef_c'] = this.wefC;
    // data['download'] = this.download;
    return data;
  }
}


