import 'package:flutter/material.dart';

class EventModel<T extends Widget> {
  final bool progress;
  final List<T> data;
  final String error;
  final bool stopLoading;

  EventModel({this.progress, this.data, this.error, this.stopLoading});
}
