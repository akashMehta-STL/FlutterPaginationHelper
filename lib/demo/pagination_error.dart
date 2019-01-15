import 'package:flutter/material.dart';
import 'package:flutter_pagination_helper/demo/list_item.dart';
import 'package:flutter_pagination_helper/pagination_helper/event_model.dart';
import 'package:flutter_pagination_helper/pagination_helper/item_list_callback.dart';
import 'package:flutter_pagination_helper/pagination_helper/list_helper.dart';

const int threshold = 13;
const int errorIndex = 20;

class PaginationErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagination with error"),
      ),
      body: PaginatedListWidget(itemListCallback: OnScrollCallback()),
    );
  }
}

class OnScrollCallback<T extends Widget> extends ItemListCallback {
  int availableItems = 0;

  @override
  Future<EventModel> getItemList() {
    if (availableItems > errorIndex) { // manage error scenario
      // return error message when available item exceed error index
      return Future.value(EventModel(progress: false, data: null, error: "Error message"));
    } else {
      // return data
      return Future.delayed(Duration(seconds: 3), () {
        List<T> itemList = List();
        for (int i = availableItems; i < availableItems + threshold; i++) {
          Widget widget;
          if (i % 5 == 0) {
            widget = TitleWidget(i);
          } else {
            widget = ListItemWidget(ItemModel("Title $i", "Subtitle $i"));
          }
          itemList.add(widget);
        }
        availableItems += threshold;
        return EventModel(progress: false, data: itemList, error: null);
      });
    }
  }
}

class TitleWidget extends StatelessWidget {
  final int i;

  TitleWidget(this.i);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[50],
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)],
          border: Border.all(color: Colors.grey[400], width: 1.0),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text(
            "This is different item no $i",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
