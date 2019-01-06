import 'package:flutter/material.dart';
import 'package:flutter_pagination_helper/pagination_helper/progressbar.dart';

class WidgetList<T extends Widget> extends StatelessWidget {
  final List<T> widgetList;
  final Function onScrollListener;
  WidgetList(this.widgetList, this.onScrollListener);

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
       onScrollListener();
      }
    });
    return ListView.builder(
      controller: _scrollController,
      itemCount: widgetList.length,
      itemBuilder: (BuildContext context, int index) => ListItem(
            model: widgetList[index],
          ),
    );
  }
}

class ListItem<T extends Widget> extends StatelessWidget {
  final T model;

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
      return model;
    }
  }
}
