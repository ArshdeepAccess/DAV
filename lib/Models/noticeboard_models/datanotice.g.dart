// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datanotice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notice _$NoticeFromJson(Map<String, dynamic> json) => Notice(
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

Map<String, dynamic> _$NoticeToJson(Notice instance) => <String, dynamic>{
      'items': instance.items,
      'hasMore': instance.hasMore,
      'limit': instance.limit,
      'offset': instance.offset,
      'count': instance.count,
      'links': instance.links,
    };
