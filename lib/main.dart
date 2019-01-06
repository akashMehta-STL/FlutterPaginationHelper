import 'package:flutter/material.dart';
import 'package:flutter_pagination_helper/bloc_provider.dart';
import 'package:flutter_pagination_helper/list_item.dart';
import 'package:flutter_pagination_helper/progressbar.dart';
import 'package:flutter_pagination_helper/widget_list.dart';
import 'pagination_bloc.dart';

void main() => runApp(MyApp());

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
        body: BlocProvider(bloc: PaginationBloc(), child: ListWidget()),
      ),
    );
  }
}

class ListWidget extends StatelessWidget {
  var itemList = List<ItemModel>();

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    PaginationBloc bloc = BlocProvider.of<PaginationBloc>(context);
    bloc.setDelay();

    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!isLoading) {
          isLoading = !isLoading;
          bloc.setDelay();
        }
      }
    });
    return StreamBuilder(
      initialData: EventModel(true, itemList),
      stream: bloc.eventStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        EventModel model = snapshot.data;
        isLoading = false;
        if (model.progress) {
          if (model.itemList.isEmpty) {
            return ProgressWidget();
          } else {
            return WidgetList(model.itemList, _scrollController);
          }
        } else {
          if (itemList.contains(null)) {
            itemList.remove(null);
          }
          itemList.addAll(model.itemList);
          itemList.add(null);
          return WidgetList(itemList, _scrollController);
        }
      },
    );
  }
}
