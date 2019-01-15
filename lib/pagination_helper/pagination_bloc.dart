import 'dart:async';
import 'package:flutter_pagination_helper/pagination_helper/bloc_provider.dart';
import 'package:flutter_pagination_helper/pagination_helper/event_model.dart';
import 'package:flutter_pagination_helper/pagination_helper/item_list_callback.dart';

class PaginationBloc extends BaseBloc {
  StreamController<EventModel> eventController = StreamController();

  Stream<EventModel> get eventStream => eventController.stream;

  Sink<EventModel> get eventSink => eventController.sink;

  final ItemListCallback itemListCallback;

  PaginationBloc({this.itemListCallback});

  void setAsyncCallback() async {
    try {
      EventModel model = await itemListCallback.getItemList();
      eventSink.add(model);
    } catch (e) {
      eventSink
          .add(EventModel(progress: false, data: null, error: e.toString()));
    }
  }

  @override
  void dispose() {
    eventController.close();
  }
}
