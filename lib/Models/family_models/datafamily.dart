
import 'package:json_annotation/json_annotation.dart';

import 'itemsfamily.dart';
import 'linksfamily.dart';
part 'datafamily.g.dart';

@JsonSerializable()
class Family
{
  final List<Items> items;
  final bool hasMore;
  final int? limit;
  final int? offset;
  final int? count;
  final List<Links> links;


  Family({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.count,
    required this.offset,
    required this.links,

  });

  factory Family.fromJson(Map<String, dynamic>json)=> _$FamilyFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyToJson(this);


}

