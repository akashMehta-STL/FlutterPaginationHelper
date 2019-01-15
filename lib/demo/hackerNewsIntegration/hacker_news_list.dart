import 'package:flutter/material.dart';
import 'package:flutter_pagination_helper/demo/hackerNewsIntegration/circular_progress_indicator.dart';
import 'package:flutter_pagination_helper/demo/hackerNewsIntegration/error_text_widget.dart';
import 'package:flutter_pagination_helper/demo/hackerNewsIntegration/news_list_bloc.dart';
import 'package:flutter_pagination_helper/demo/hackerNewsIntegration/news_list_item.dart';
import 'package:flutter_pagination_helper/demo/hackerNewsIntegration/news_response.dart';
import 'package:flutter_pagination_helper/pagination_helper/bloc_provider.dart';

class HackerNewsListWidget extends StatefulWidget {
  final String type;
  EventModel model;

  HackerNewsListWidget(this.type) : assert(type != null);

  @override
  _HackerNewsListWidgetState createState() => _HackerNewsListWidgetState();
}

class _HackerNewsListWidgetState extends State<HackerNewsListWidget>
    with AutomaticKeepAliveClientMixin<HackerNewsListWidget> {
  NewsListBloc newsListBloc;
  List<NewsResponseItem> itemList = List<NewsResponseItem>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    newsListBloc = BlocProvider.of<NewsListBloc>(context);
    newsListBloc.fetchNewsItems(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: _createList(context, newsListBloc));
  }

  Widget _createList(BuildContext context, NewsListBloc newsListBloc) {
    return StreamBuilder(
        initialData: EventModel(true, null, null),
        stream: newsListBloc.eventStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          widget.model = snapshot.data;
          return _getPage(snapshot.data);
        });
  }

  Widget _getPage(EventModel model) {
    isLoading = false;
    if (model.progress) {
      if (itemList.isEmpty) {
        return ProgressIndicatorWidget();
      } else {
        return _createListView(itemList);
      }
    } else if (model.response != null) {
      if (itemList.contains(null)) {
        itemList.remove(null);
      }
      itemList.addAll(model.response);
      itemList.add(null);
      return _createListView(itemList);
    } else {
      if (itemList.isEmpty) {
        return ErrorTextWidget(model.error);
      } else {
        return _createListView(itemList);
      }
    }
  }

  Widget _createListView(List<NewsResponseItem> itemList) {
    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!isLoading) {
          isLoading = !isLoading;
          newsListBloc.fetchNewsItems(widget.type);
        }
      }
    });
    return ListView.builder(
        controller: _scrollController,
        itemCount: itemList.length,
        itemBuilder: (BuildContext context, int index) =>
            NewsListItem(itemList[index]));
  }

  @override
  bool get wantKeepAlive => true;
}
