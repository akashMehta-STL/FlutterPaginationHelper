import 'package:flutter/material.dart';
import 'package:flutter_pagination_helper/demo/hackerNewsIntegration/news_list_bloc.dart';
import 'package:flutter_pagination_helper/demo/hackerNewsIntegration/news_response.dart';
import 'package:flutter_pagination_helper/pagination_helper/bloc_provider.dart';
import 'package:flutter_pagination_helper/pagination_helper/event_model.dart';
import 'package:flutter_pagination_helper/pagination_helper/item_list_callback.dart';
import 'package:flutter_pagination_helper/pagination_helper/list_helper.dart';

// ignore: must_be_immutable
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
  }

  @override
  Widget build(BuildContext context) {
    return PaginatedListWidget(itemListCallback: OnScrollCallback(newsListBloc, widget.type));
  }

  @override
  bool get wantKeepAlive => true;
}

class OnScrollCallback<T extends Widget> extends ItemListCallback {
  final NewsListBloc _newsListBloc;
  final String type;

  OnScrollCallback(this._newsListBloc, this.type);

  @override
  Future<EventModel> getItemList() {
    return _newsListBloc.fetchNewsItems(type).first;
  }
}
