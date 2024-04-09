

import 'package:json_annotation/json_annotation.dart';

part 'itemsfaqofficer.g.dart';

@JsonSerializable()
class Items
{



  final int? hsd_sr_no;
  final String? hsd_detail;
  final String? hsd_pdf_link;



  Items({
    required this.hsd_sr_no,
    required this.hsd_detail,
    required this.hsd_pdf_link,


  });

  factory Items.fromJson(Map<String, dynamic>json)=> _$ItemsFromJson(json);
  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

