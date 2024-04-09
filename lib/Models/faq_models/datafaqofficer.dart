
import 'package:json_annotation/json_annotation.dart';

import 'itemsfaqofficer.dart';
import 'linksfaqofficer.dart';
part 'datafaqofficer.g.dart';

@JsonSerializable()
class Faqofficer
{
  final List<Items> items;
  final bool hasMore;
  final int? limit;
  final int? offset;
  final int? count;
  final List<Links> links;


  Faqofficer({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.count,
    required this.offset,
    required this.links,

  });

  factory Faqofficer.fromJson(Map<String, dynamic>json)=> _$FaqofficerFromJson(json);
  Map<String, dynamic> toJson() => _$FaqofficerToJson(this);


}

