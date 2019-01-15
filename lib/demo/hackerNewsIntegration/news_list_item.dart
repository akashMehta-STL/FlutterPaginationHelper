import 'package:flutter/material.dart';
import 'package:flutter_pagination_helper/demo/hackerNewsIntegration/circular_progress_indicator.dart';
import 'package:flutter_pagination_helper/demo/hackerNewsIntegration/news_response.dart';

class NewsListItem extends StatelessWidget {
  final NewsResponseItem newsResponseItem;

  NewsListItem(this.newsResponseItem);

  @override
  Widget build(BuildContext context) {
    return Container(child: _rowWidget(context, newsResponseItem));
  }

  Widget _rowWidget(BuildContext context, NewsResponseItem newsResponseItem) {
    if (newsResponseItem == null) {
      return Center(
        child: ProgressIndicatorWidget(),
      );
    } else {
      return Material(
        child: InkWell(
          child: Padding(
            padding: EdgeInsets.only(top: 16, bottom: 16, left: 10, right: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[50],
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)],
                  border: Border.all(color: Colors.grey[400], width: 1.0),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  newsResponseItem.title,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
