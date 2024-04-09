
import 'package:json_annotation/json_annotation.dart';

import 'itemsdisability.dart';
import 'linksdisability.dart';
part 'datadisability.g.dart';

@JsonSerializable()
class Disability
{
  final List<Items> items;
  final bool hasMore;
  final int? limit;
  final int? offset;
  final int? count;
  final List<Links> links;


  Disability({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.count,
    required this.offset,
    required this.links,

  });

  factory Disability.fromJson(Map<String, dynamic>json)=> _$DisabilityFromJson(json);
  Map<String, dynamic> toJson() => _$DisabilityToJson(this);


}

