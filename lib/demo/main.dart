import 'package:flutter/material.dart';
import 'package:flutter_pagination_helper/demo/custom_progress_pagination.dart';
import 'package:flutter_pagination_helper/demo/default_progress_pagination.dart';
import 'package:flutter_pagination_helper/demo/pagination_error.dart';

void main() => runApp(MyApp());

const DEFAULT_PROGRESS_PAGINATION = 0;
const CUSTOM_PROGRESS_PAGINATION = 1;
const ERROR_PAGINATION = 2;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Pagination Sample"),
            ),
            body: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      onPressed: () {
                        navigateToPagination(
                            context, CUSTOM_PROGRESS_PAGINATION);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("Custom progress pagination"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      onPressed: () {
                        navigateToPagination(
                            context, DEFAULT_PROGRESS_PAGINATION);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("Default progress pagination"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      onPressed: () {
                        navigateToPagination(context, ERROR_PAGINATION);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("Error pagination"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void navigateToPagination(BuildContext context, int page) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      if (page == DEFAULT_PROGRESS_PAGINATION) {
        return DefaultProgressWidget();
      } else if (page == CUSTOM_PROGRESS_PAGINATION) {
        return CustomProgressWidget();
      } else {
        return PaginationErrorWidget();
      }
    }));
  }
}
