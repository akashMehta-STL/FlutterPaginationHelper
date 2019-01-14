import 'package:flutter/material.dart';
import 'package:flutter_pagination_helper/pagination_helper/bloc_provider.dart';
import 'package:flutter_pagination_helper/pagination_helper/pagination_bloc.dart';
import 'package:flutter_pagination_helper/pagination_helper/item_list_callback.dart';
import 'package:flutter_pagination_helper/pagination_helper/list_widget.dart';

class ListHelper extends StatelessWidget {
  final ItemListCallback itemListCallback;
  final Widget progressWidget;

  ListHelper({this.progressWidget, this.itemListCallback});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: PaginationBloc(itemListCallback: itemListCallback),
        child: ListWidget(
          progressWidget: progressWidget,
        ));
  }
}
