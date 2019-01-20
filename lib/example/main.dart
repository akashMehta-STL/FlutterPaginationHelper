import 'package:flutter/material.dart';
import 'package:flutter_pagination_helper/pagination_helper/event_model.dart';
import 'package:flutter_pagination_helper/pagination_helper/item_list_callback.dart';
import 'package:flutter_pagination_helper/pagination_helper/list_helper.dart';

const int threshold = 13;
const int totalItems = 39;

void main() => runApp(CustomProgressWidget());

class CustomProgressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pagination with custom progress"),
        ),
        body: PaginatedListWidget(
            progressWidget: Center(
              child: Text("Loading..."),
            ),
            itemListCallback: OnScrollCallback()),
      ),
    );
  }
}

class OnScrollCallback<T extends Widget> extends ItemListCallback {
  int availableItems = 0;

  @override
  Future<EventModel> getItemList() {
    return Future.delayed(Duration(seconds: 3), () {
      List<T> itemList = List();
      if (availableItems < totalItems) {
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
      } else {
        for (int i = availableItems; i < availableItems + 3; i++) {
          Widget widget = ListItemWidget(ItemModel("Title $i", "Subtitle $i"));
          itemList.add(widget);
        }
        availableItems += 3;
        return EventModel(
            progress: false, data: itemList, error: null, stopLoading: true);
      }
    });
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
            "Header $i",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class ListItemWidget extends StatelessWidget {
  final ItemModel itemModel;
  ListItemWidget(this.itemModel);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              itemModel.title,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              itemModel.subTitle,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    ));
  }
}

class ItemModel {
  final String title;
  final String subTitle;

  ItemModel(this.title, this.subTitle);
}
