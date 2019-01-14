import 'package:flutter_pagination_helper/pagination_helper/event_model.dart';
import 'package:flutter_pagination_helper/pagination_helper/progressbar.dart';
import 'package:flutter_pagination_helper/pagination_helper/widget_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagination_helper/pagination_helper/bloc_provider.dart';
import 'package:flutter_pagination_helper/pagination_helper/pagination_bloc.dart';

class ListWidget<T extends Widget> extends StatelessWidget {
  final _itemList = List<T>();

  final Widget progressWidget;

  ListWidget({this.progressWidget});

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    PaginationBloc bloc = BlocProvider.of<PaginationBloc>(context);
    bloc.setAsyncCallback();

    Function _onScrollListener = () {
      if (!isLoading) {
        isLoading = !isLoading;
        bloc.setAsyncCallback();
      }
    };

    return StreamBuilder(
      initialData: EventModel(true, _itemList, null),
      stream: bloc.eventStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        EventModel<T> model = snapshot.data;
        isLoading = false;
        if (model.progress) { // Handle progress state
          if (model.itemList.isEmpty) {
            return progressWidget ?? ProgressWidget();
          } else {
            return WidgetList(model.itemList, progressWidget, _onScrollListener);
          }
        } else if(model.errorMessage != null) { // Handle error state
          if (_itemList.contains(null)) {
            _itemList.remove(null);
          }
          return WidgetList(_itemList, progressWidget, _onScrollListener);
        } else { // Handle data state
          if (_itemList.contains(null)) {
            _itemList.remove(null);
          }
          _itemList.addAll(model.itemList);
          _itemList.add(null);
          return WidgetList(_itemList, progressWidget, _onScrollListener);
        }
      },
    );
  }
}
