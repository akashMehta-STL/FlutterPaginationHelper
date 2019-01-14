import 'package:flutter/material.dart';
import 'package:flutter_pagination_helper/list_item.dart';
import 'package:flutter_pagination_helper/pagination_helper/item_list_callback.dart';
import 'package:flutter_pagination_helper/pagination_helper/list_helper.dart';

void main() => runApp(MyApp());
const int threshold = 13;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pagination Helper"),
        ),
        body: ListHelper(itemListCallback: Callback()),
      ),
    );
  }
}

class Callback<T extends Widget> extends ItemListCallback {
  int availableItems = 0;

  @override
  Future<List<T>> getItemList() {
    return Future.delayed(Duration(seconds: 3), () {
      List<T> itemList = List();
      for (int i = availableItems; i < availableItems + threshold; i++) {
        Widget widget;
        if (i % 5 == 0) {
          widget = Container(
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
        } else {
          widget = ListItemWidget(ItemModel("Title $i", "Subtitle $i"));
        }
        itemList.add(widget);
      }
      availableItems += threshold;
      return itemList;
    });
  }
}
