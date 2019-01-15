import 'package:flutter/material.dart';
import 'package:flutter_pagination_helper/demo/custom_progress_pagination.dart';
import 'package:flutter_pagination_helper/demo/default_progress_pagination.dart';
import 'package:flutter_pagination_helper/demo/hackerNewsIntegration/news_home.dart';
import 'package:flutter_pagination_helper/demo/pagination_error.dart';

void main() => runApp(MyApp());

const DEFAULT_PROGRESS_PAGINATION = 0;
const CUSTOM_PROGRESS_PAGINATION = 1;
const ERROR_PAGINATION = 2;
const HACKER_NEWS = 3;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Pagination Sample"),
            ),
            body: Center(
              child: Column(
                children: <Widget>[
                  PaginationButton(
                      "Custom progress pagination", CUSTOM_PROGRESS_PAGINATION),
                  PaginationButton("Default progress pagination",
                      DEFAULT_PROGRESS_PAGINATION),
                  PaginationButton("Error pagination", ERROR_PAGINATION),
                  PaginationButton("Hacker news", HACKER_NEWS),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PaginationButton extends StatelessWidget {
  final String title;
  final int page;

  PaginationButton(this.title, this.page);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: RaisedButton(
        onPressed: () {
          _navigateToPagination(context, page);
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(title),
        ),
      ),
    );
  }

  void _navigateToPagination(BuildContext context, int page) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      switch (page) {
        case DEFAULT_PROGRESS_PAGINATION:
          return DefaultProgressWidget();
        case CUSTOM_PROGRESS_PAGINATION:
          return CustomProgressWidget();
        case ERROR_PAGINATION:
          return PaginationErrorWidget();
        case HACKER_NEWS:
          return NewsHomeWidget();
      }
    }));
  }
}
