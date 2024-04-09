

import 'package:json_annotation/json_annotation.dart';

part 'itemsechsmain.g.dart';

@JsonSerializable()
class Items
{

  final String? d;
  final String? r;



  Items({
    required this.d,
    required this.r,


  });

  factory Items.fromJson(Map<String, dynamic>json)=> _$ItemsFromJson(json);
  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

