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
        body: ListHelper(threshold: threshold, itemListCallback: Callback()),
      ),
    );
  }
}

class Callback extends ItemListCallback {
  @override
  List<ListItemWidget> getItemList(int availableItems) {
    List<ListItemWidget> itemList = List();
    for (int i = availableItems; i < availableItems + threshold; i++) {
      itemList.add(ListItemWidget(ItemModel("Title $i", "Subtitle $i")));
    }
    return itemList;
  }
}
