part of pagination_helper;

class PaginationBloc extends BaseBloc {
  StreamController<EventModel> eventController = StreamController();

  Stream<EventModel> get eventStream => eventController.stream;

  Sink<EventModel> get eventSink => eventController.sink;

  final ItemListCallback itemListCallback;

  PaginationBloc({required this.itemListCallback});

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
