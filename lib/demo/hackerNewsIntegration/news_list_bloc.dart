import 'dart:async';
import 'dart:convert';

import 'package:flutter_pagination_helper/demo/hackerNewsIntegration/news_response.dart';
import 'package:flutter_pagination_helper/pagination_helper/bloc_provider.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';

class NewsListBloc extends BaseBloc {
  StreamController<EventModel> _eventController = new StreamController();

  Sink<EventModel> get _eventSink => _eventController.sink;

  Stream<EventModel> get eventStream => _eventController.stream;
  int _skipCount = 0;

  List<int> idList = List();

  void fetchNewsItems(String newsType) {
    if (idList.isEmpty) {
      Observable<List<int>> _newsIdFuture =
      Observable.fromFuture(fetchNewsIds(newsType));
      _newsIdFuture.doOnData((idList) {
        this.idList.clear();
        this.idList.addAll(idList);
        displayNewsItems();
      }).listen(print);
    } else {
      displayNewsItems();
    }

  }

  void displayNewsItems() {
    AsObservableFuture future = Observable.just(idList)
        .flatMapIterable((id) => Observable.just(id))
        .skip(_skipCount)
        .take(10)
        .flatMap((id) => Observable.fromFuture(_fetchNewsItems(id)))
        .toList();
    Observable.fromFuture(future).doOnListen(() {
      _eventSink.add(EventModel(true, null, null));
    }).doOnError((error, stacktrace) {
      _eventSink.add(EventModel(false, null, error.toString()));
    }).listen((itemList) {
      List<NewsResponseItem> newsItems = itemList;
      _skipCount += newsItems.length;
      _eventSink.add(EventModel(false, newsItems, null));
    });
  }

  Future<NewsResponseItem> _fetchNewsItems(int id) async {
    final response =
        await get("https://hacker-news.firebaseio.com/v0/item/$id.json");
    if (response.statusCode == 200) {
      return NewsResponseItem.fromJson(JsonDecoder().convert(response.body));
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
    _eventController.close();
  }
}

class EventModel {
  final bool progress;
  final List<NewsResponseItem> response;
  final String error;

  EventModel(this.progress, this.response, this.error);
}