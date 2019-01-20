import 'package:flutter_pagination_helper/pagination_helper/event_model.dart';

abstract class ItemListCallback {
  Future<EventModel> getItemList();
}
