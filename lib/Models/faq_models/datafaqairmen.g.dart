// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datafaqairmen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Faqairmen _$FaqairmenFromJson(Map<String, dynamic> json) => Faqairmen(
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

Map<String, dynamic> _$FaqairmenToJson(Faqairmen instance) => <String, dynamic>{
      'items': instance.items,
      'hasMore': instance.hasMore,
      'limit': instance.limit,
      'offset': instance.offset,
      'count': instance.count,
      'links': instance.links,
    };
