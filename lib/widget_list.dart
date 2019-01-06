import 'package:flutter/material.dart';
import 'package:flutter_pagination_helper/list_item.dart';
import 'package:flutter_pagination_helper/progressbar.dart';

class WidgetList extends StatelessWidget {
  final List<ItemModel> widgetList;
  final ScrollController scrollController;

  WidgetList(this.widgetList, this.scrollController);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: widgetList.length,
      itemBuilder: (BuildContext context, int index) => ListItem(
            model: widgetList[index],
          ),
    );
  }
}

class ListItem extends StatelessWidget {
  final ItemModel model;

  ListItem({Key key, this.model});

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: ProgressWidget(),
        ),
      );
    } else {
      return ListItemWidget(model);
    }
  }
}
