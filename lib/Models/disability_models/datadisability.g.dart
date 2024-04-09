// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datadisability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Disability _$DisabilityFromJson(Map<String, dynamic> json) => Disability(
      items: (json['items'] as List<dynamic>)
          .map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasMore: json['hasMore'] as bool,
      limit: json['limit'] as int?,
      count: json['count'] as int?,
      offset: json['offset'] as int?,
      links: (json['links'] as List<dynamic>)
          .map((e) => Links.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DisabilityToJson(Disability instance) =>
    <String, dynamic>{
      'items': instance.items,
      'hasMore': instance.hasMore,
      'limit': instance.limit,
      'offset': instance.offset,
      'count': instance.count,
      'links': instance.links,
    };
