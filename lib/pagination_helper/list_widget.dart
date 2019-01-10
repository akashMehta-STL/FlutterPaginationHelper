import 'package:flutter_pagination_helper/pagination_helper/progressbar.dart';
import 'package:flutter_pagination_helper/pagination_helper/widget_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagination_helper/pagination_helper/bloc_provider.dart';
import 'package:flutter_pagination_helper/pagination_helper/pagination_bloc.dart';

class ListWidget<T extends Widget> extends StatelessWidget {
  var itemList = List<T>();

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    PaginationBloc bloc = BlocProvider.of<PaginationBloc>(context);
    bloc.setDelay();

    Function _onScrollListener = () {
      if (!isLoading) {
        isLoading = !isLoading;
        bloc.setDelay();
      }
    };

    return StreamBuilder(
      initialData: EventModel(true, itemList),
      stream: bloc.eventStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        EventModel<T> model = snapshot.data;
        isLoading = false;
        if (model.progress) {
          if (model.itemList.isEmpty) {
            return ProgressWidget();
          } else {
            return WidgetList(model.itemList, _onScrollListener);
          }
        } else {
          if (itemList.contains(null)) {
            itemList.remove(null);
          }
          itemList.addAll(model.itemList);
          itemList.add(null);
          return WidgetList(itemList, _onScrollListener);
        }
      },
    );
  }
}
