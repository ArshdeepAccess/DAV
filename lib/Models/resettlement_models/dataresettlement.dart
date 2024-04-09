
import 'package:json_annotation/json_annotation.dart';

import 'itemsresettlement.dart';
import 'linksresettlement.dart';
part 'dataresettlement.g.dart';

@JsonSerializable()
class Resettlement
{
  final List<Items> items;
  final bool hasMore;
  final int? limit;
  final int? offset;
  final int? count;
  final List<Links> links;


  Resettlement({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.count,
    required this.offset,
    required this.links,

  });

  factory Resettlement.fromJson(Map<String, dynamic>json)=> _$ResettlementFromJson(json);
  Map<String, dynamic> toJson() => _$ResettlementToJson(this);


}

