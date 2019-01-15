import 'package:flutter/material.dart';
import 'package:flutter_pagination_helper/demo/hackerNewsIntegration/hacker_news_list.dart';
import 'package:flutter_pagination_helper/demo/hackerNewsIntegration/news_list_bloc.dart';
import 'package:flutter_pagination_helper/pagination_helper/bloc_provider.dart';

class NewsHomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: _defaultTabController());
  }

  Widget _defaultTabController() {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Hacker News"),
            centerTitle: true,
            bottom: TabBar(
                tabs: [Tab(text: "New"), Tab(text: "Top"), Tab(text: "Best")]),
          ),
          body: TabBarView(children: [
            BlocProvider(bloc: NewsListBloc(), child: HackerNewsListWidget("New"),),
            BlocProvider(bloc: NewsListBloc(), child: HackerNewsListWidget("Top"),),
            BlocProvider(bloc: NewsListBloc(), child: HackerNewsListWidget("Best"))
          ]),
        ));
  }
}
