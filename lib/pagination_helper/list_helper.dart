import 'package:flutter/material.dart';
import 'package:flutter_pagination_helper/pagination_helper/bloc_provider.dart';
import 'package:flutter_pagination_helper/pagination_helper/pagination_bloc.dart';
import 'package:flutter_pagination_helper/pagination_helper/item_list_callback.dart';
import 'package:flutter_pagination_helper/pagination_helper/list_widget.dart';

class ListHelper extends StatelessWidget {
  final ItemListCallback itemListCallback;
  final int threshold;
  ListHelper({this.threshold,this.itemListCallback});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: PaginationBloc(threshold: threshold, itemListCallback: itemListCallback),
        child: ListWidget());
  }
}
