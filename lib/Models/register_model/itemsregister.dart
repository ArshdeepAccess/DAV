

import 'package:json_annotation/json_annotation.dart';

part 'itemsregister.g.dart';

@JsonSerializable()
class Items
{



  final int? result;




  Items({
    required this.result,



  });

  factory Items.fromJson(Map<String, dynamic>json)=> _$ItemsFromJson(json);
  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

