import 'dart:async';
import 'package:flutter_pagination_helper/bloc_provider.dart';
import 'package:flutter_pagination_helper/list_item.dart';

class PaginationBloc extends BaseBloc {
  StreamController<EventModel> eventController = StreamController();

  Stream<EventModel> get eventStream => eventController.stream;

  Sink<EventModel> get eventSink => eventController.sink;

  int index = 0;

  void setDelay() {
    Future.delayed(Duration(seconds: 3), () {
      List<ItemModel> itemList = List();
      for (int i = index; i < index + 10; i++) {
        itemList.add(ItemModel("Title $i", "Subtitle $i"));
      }
      index += 10;
      eventSink.add(EventModel(false, itemList));
    });
  }

  @override
  void dispose() {
    eventController.close();
  }
}

class EventModel {
  final bool progress;
  final List<ItemModel> itemList;

  EventModel(this.progress, this.itemList);
}
