import 'package:dav2/Models/update_models/itemsupdate.dart';
import 'package:dav2/Models/update_models/linksupdate.dart';
import 'package:json_annotation/json_annotation.dart';
part 'datanotice.g.dart';

@JsonSerializable()
class Notice
{
  final List<Items> items;
  final bool hasMore;
  final int? limit;
  final int? offset;
  final int? count;
  final List<Links> links;


  Notice({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.count,
    required this.offset,
    required this.links,

  });

  factory Notice.fromJson(Map<String, dynamic>json)=> _$NoticeFromJson(json);
  Map<String, dynamic> toJson() => _$NoticeToJson(this);


}

