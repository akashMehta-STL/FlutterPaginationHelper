import 'package:json_annotation/json_annotation.dart';

part 'news_response.g.dart';
/*
 * run 
 * flutter packages pub run build_runner build
 * to auto generate model file 
 */

@JsonSerializable()
class NewsResponseItem {
  final String by;
  final int descendants;
  final int id;
  final int score;
  final int time;
  final String title;
  final String type;
  final String url;

  NewsResponseItem(this.by, this.descendants, this.id, this.score, this.time,
      this.title, this.type, this.url);

  factory NewsResponseItem.fromJson(Map jsonMap) =>
      _$NewsResponseItemFromJson(jsonMap);

  Map<String, dynamic> toJson() => _$NewsResponseItemToJson(this);
}

class NewsResponseApiModel {
  final bool isLoading;
  final List<NewsResponseItem> idList;
  final String error;

  NewsResponseApiModel(this.isLoading, this.idList, this.error);
}
