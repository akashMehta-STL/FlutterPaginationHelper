import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pagination_helper/pagination_helper/bloc_provider.dart';
import 'package:flutter_pagination_helper/pagination_helper/item_list_callback.dart';

class PaginationBloc<T extends Widget> extends BaseBloc {
  StreamController<EventModel> eventController = StreamController();

  Stream<EventModel> get eventStream => eventController.stream;

  Sink<EventModel> get eventSink => eventController.sink;

  final ItemListCallback<T> itemListCallback;
  PaginationBloc({this.itemListCallback});

  void setDelay() async {
    List<T> itemList = await itemListCallback.getItemList();
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
