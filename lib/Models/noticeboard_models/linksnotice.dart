import 'package:json_annotation/json_annotation.dart';
part 'linksnotice.g.dart';

@JsonSerializable()
class Links
{

  final String? rel;
  final String? href;




  Links({
    required this.rel,
    required this.href,



  });

  factory Links.fromJson(Map<String, dynamic>json)=> _$LinksFromJson(json);
  Map<String, dynamic> toJson() => _$LinksToJson(this);
}

