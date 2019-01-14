import 'package:flutter/material.dart';

class EventModel<T extends Widget> {
  final bool progress;
  final List<T> itemList;
  final String errorMessage;

  EventModel(this.progress, this.itemList, this.errorMessage);
}
