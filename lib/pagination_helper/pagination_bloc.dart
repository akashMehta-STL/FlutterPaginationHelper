import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pagination_helper/pagination_helper/bloc_provider.dart';
import 'package:flutter_pagination_helper/pagination_helper/item_list_callback.dart';

class PaginationBloc<T extends Widget> extends BaseBloc {
  StreamController<EventModel> eventController = StreamController();

  Stream<EventModel> get eventStream => eventController.stream;

  Sink<EventModel> get eventSink => eventController.sink;

  int _index = 0;

  final int threshold;
  final ItemListCallback<T> itemListCallback;

  PaginationBloc({this.threshold, this.itemListCallback});

  void setDelay() async {
    List<T> itemList =
        await Future.delayed(Duration(seconds: 3), () {
          return itemListCallback.getItemList(_index);
        });
    _index += threshold;
    eventSink.add(EventModel(false, itemList));
  }

  @override
  void dispose() {
    eventController.close();
  }
}

class EventModel<T extends Widget> {
  final bool progress;
  final List<T> itemList;

  EventModel(this.progress, this.itemList);
}
