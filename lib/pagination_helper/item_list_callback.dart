import 'package:flutter/material.dart';
import 'package:flutter_pagination_helper/pagination_helper/pagination_bloc.dart';

abstract class ItemListCallback {
  Future<EventModel> getItemList();
}