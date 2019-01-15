// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsResponseItem _$NewsResponseItemFromJson(Map<String, dynamic> json) {
  return NewsResponseItem(
      json['by'] as String,
      json['descendants'] as int,
      json['id'] as int,
      json['score'] as int,
      json['time'] as int,
      json['title'] as String,
      json['type'] as String,
      json['url'] as String);
}

Map<String, dynamic> _$NewsResponseItemToJson(NewsResponseItem instance) =>
    <String, dynamic>{
      'by': instance.by,
      'descendants': instance.descendants,
      'id': instance.id,
      'score': instance.score,
      'time': instance.time,
      'title': instance.title,
      'type': instance.type,
      'url': instance.url
    };
