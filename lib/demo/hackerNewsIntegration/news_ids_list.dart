import 'package:json_annotation/json_annotation.dart';

part 'news_ids_list.g.dart';
/*
 * run 
 * flutter packages pub run build_runner build
 * to auto generate model file 
 */

@JsonSerializable()
class NewsIdList {
  final List<int> ids;

  NewsIdList(this.ids);

  factory NewsIdList.fromJson(Map jsonMap) => _$NewsIdListFromJson(jsonMap);

  Map<String, dynamic> toJson() => _$NewsIdListToJson(this);
}

class NewsIdApiModel {
  final bool isLoading;
  final List<int> idList;
  final String error;

  NewsIdApiModel(this.isLoading, this.idList, this.error);
}
