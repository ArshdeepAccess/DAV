
import 'package:json_annotation/json_annotation.dart';

import 'itemsfaqairmen.dart';
import 'linksfaqairmen.dart';
part 'datafaqairmen.g.dart';

@JsonSerializable()
class Faqairmen
{
  final List<Items> items;
  final bool hasMore;
  final int? limit;
  final int? offset;
  final int? count;
  final List<Links> links;


  Faqairmen({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.count,
    required this.offset,
    required this.links,

  });

  factory Faqairmen.fromJson(Map<String, dynamic>json)=> _$FaqairmenFromJson(json);
  Map<String, dynamic> toJson() => _$FaqairmenToJson(this);


}

