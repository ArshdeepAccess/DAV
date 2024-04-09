
import 'package:json_annotation/json_annotation.dart';

import 'itemsechs.dart';
import 'linksechs.dart';
part 'dataechs.g.dart';

@JsonSerializable()
class Echs
{
  final List<Items> items;
  final bool hasMore;
  final int? limit;
  final int? offset;
  final int? count;
  final List<Links> links;


  Echs({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.count,
    required this.offset,
    required this.links,

  });

  factory Echs.fromJson(Map<String, dynamic>json)=> _$EchsFromJson(json);
  Map<String, dynamic> toJson() => _$EchsToJson(this);


}

