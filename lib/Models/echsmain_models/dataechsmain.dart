
import 'package:json_annotation/json_annotation.dart';

import 'itemsechsmain.dart';
import 'linksechsmain.dart';
part 'dataechsmain.g.dart';

@JsonSerializable()
class Echsmain
{
  final List<Items> items;
  final bool hasMore;
  final int? limit;
  final int? offset;
  final int? count;
  final List<Links> links;


  Echsmain({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.count,
    required this.offset,
    required this.links,

  });

  factory Echsmain.fromJson(Map<String, dynamic>json)=> _$EchsmainFromJson(json);
  Map<String, dynamic> toJson() => _$EchsmainToJson(this);


}

