import 'package:flutter/material.dart';

abstract class ItemListCallback<T extends Widget> {
  Future<List<T>> getItemList();
}