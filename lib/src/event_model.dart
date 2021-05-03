part of pagination_helper;

class EventModel<T extends Widget> {
  final bool? progress;
  final List<T>? data;
  final String? error;
  final bool? stopLoading;

  EventModel({this.progress, this.data, this.error, this.stopLoading});
}
