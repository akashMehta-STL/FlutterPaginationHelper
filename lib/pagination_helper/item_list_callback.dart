import 'package:flutter/material.dart';

abstract class ItemListCallback<T extends Widget> {
  List<T> getItemList(int availableItems);
}