import 'package:flutter_pagination_helper/pagination_helper/event_model.dart';
import 'package:flutter_pagination_helper/pagination_helper/progressbar.dart';
import 'package:flutter_pagination_helper/pagination_helper/widget_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagination_helper/pagination_helper/bloc_provider.dart';
import 'package:flutter_pagination_helper/pagination_helper/pagination_bloc.dart';

class ListWidget<T extends Widget> extends StatelessWidget {
  final _itemList = List<T>();

  final Widget progressWidget;
  final GlobalKey<ScaffoldState> scaffoldKey;

  ListWidget({this.progressWidget, this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    bool isLoadComplete = false;
    PaginationBloc bloc = BlocProvider.of<PaginationBloc>(context);
    bloc.setAsyncCallback();

    Function _onScrollListener = () {
      if (!isLoading && !isLoadComplete) {
        isLoading = !isLoading;
        bloc.setAsyncCallback();
      }
    };

    return StreamBuilder(
      initialData: EventModel(progress: true, data: _itemList, error: null),
      stream: bloc.eventStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        EventModel<T> model = snapshot.data;
        isLoading = false;
        if (model.progress) {
          // Handle progress state
          if (model.data.isEmpty) {
            return progressWidget ?? ProgressWidget();
          } else {
            return WidgetList(model.data, progressWidget, _onScrollListener);
          }
        } else if (model.error != null) {
          // Handle error state
          if (_itemList.contains(null)) {
            _itemList.remove(null);
          }

          // Show SnackBar on error.
          Future.delayed(Duration(milliseconds: 500), () {
            scaffoldKey.currentState
                .showSnackBar(SnackBar(content: Text(model.error)));
          });

          return WidgetList(_itemList, progressWidget, _onScrollListener);
        } else {
          // Handle data state
          if (_itemList.contains(null)) {
            _itemList.remove(null);
          }
          _itemList.addAll(model.data);

          // If list reach to the bottom of the page then model.stopLoading flag will become
          // true and after displaying remaining data progress will not be shown.
          if (model.stopLoading != null && model.stopLoading) {
            isLoadComplete = true;
          } else {
            _itemList.add(null);
          }
          return WidgetList(_itemList, progressWidget, _onScrollListener);
        }
      },
    );
  }
}
