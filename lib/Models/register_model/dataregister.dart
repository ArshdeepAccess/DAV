import 'package:json_annotation/json_annotation.dart';
import 'itemsregister.dart';
import 'linksregister.dart';
part 'dataregister.g.dart';

@JsonSerializable()
class Register
{
  final List<Items> items;
  final bool hasMore;
  final int? limit;
  final int? offset;
  final int? count;
  final List<Links> links;

  Register({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.count,
    required this.offset,
    required this.links,
  });

  factory Register.fromJson(Map<String, dynamic>json)=> _$RegisterFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterToJson(this);
}

