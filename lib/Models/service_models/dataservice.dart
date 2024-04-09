
import 'package:json_annotation/json_annotation.dart';

import 'itemsservice.dart';
import 'linksservice.dart';
part 'dataservice.g.dart';

@JsonSerializable()
class Service
{
  final List<Items> items;
  final bool hasMore;
  final int? limit;
  final int? offset;
  final int? count;
  final List<Links> links;


  Service({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.count,
    required this.offset,
    required this.links,

  });

  factory Service.fromJson(Map<String, dynamic>json)=> _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);


}

