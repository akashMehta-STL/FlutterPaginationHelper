import 'dart:async';
import 'dart:convert';

import 'package:flutter_pagination_helper/demo/hackerNewsIntegration/news_list_item.dart';
import 'package:flutter_pagination_helper/demo/hackerNewsIntegration/news_response.dart';
import 'package:flutter_pagination_helper/pagination_helper/bloc_provider.dart';
import 'package:flutter_pagination_helper/pagination_helper/event_model.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';

class NewsListBloc extends BaseBloc {
  int _skipCount = 0;

  List<int> idList = List();

  Observable<EventModel> fetchNewsItems(String newsType) {
    if (idList.isEmpty) {
      Observable<List<int>> _newsIdFuture = Observable.fromFuture(fetchNewsIds(newsType));
      Observable<EventModel> _newsItem = _newsIdFuture.concatMap((idList) {
        this.idList.addAll(idList);
        return displayNewsItems();
      });
      return _newsItem;
    } else {
      return displayNewsItems();
    }

  }

  Observable<EventModel> displayNewsItems() {
    return Observable.just(idList)
        .flatMapIterable((id) => Observable.just(id))
        .skip(_skipCount)
        .take(10)
        .flatMap((id) => Observable.fromFuture(_fetchNewsItems(id)))
        .toList().asObservable().map((data) { return EventModel(progress: false, data: data, error: null);});
  }

  Future<NewsListItem> _fetchNewsItems(int id) async {
    final response =
        await get("https://hacker-news.firebaseio.com/v0/item/$id.json");
    if (response.statusCode == 200) {
      return NewsListItem(NewsResponseItem.fromJson(JsonDecoder().convert(response.body)));
    } else {
      throw Exception(response.body);
    }
  }

  Future<List<int>> fetchNewsIds(String newsType) async {
    final response = await get(
        "https://hacker-news.firebaseio.com/v0/${newsType.toLowerCase() + "stories"}.json");
    if (response.statusCode == 200) {
      List<int> idList = List();
      List<dynamic> responseList = JsonDecoder().convert(response.body);
      for (var value in responseList) {
        if (value is int) {
          idList.add(value);
        }
      }
      return idList;
    } else {
      throw Exception(response.body);
    }
  }

  @override
  void dispose() {
  }
}