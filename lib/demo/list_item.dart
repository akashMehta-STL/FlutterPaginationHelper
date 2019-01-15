import 'package:flutter/material.dart';

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
