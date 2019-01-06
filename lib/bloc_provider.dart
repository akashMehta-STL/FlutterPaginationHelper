import 'package:flutter/material.dart';

abstract class BaseBloc {
  void dispose();
}

class BlocProvider<T extends BaseBloc> extends StatelessWidget {
  final T bloc;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }

  static T of<T extends BaseBloc>(BuildContext context) {
    final type = typeOf<BlocProvider<T>>();
    BlocProvider<T> blocProvider = context.ancestorWidgetOfExactType(type);
    return blocProvider.bloc;
  }

  BlocProvider({Key key, @required this.bloc, @required this.child})
      : super(key: key);

  static Type typeOf<T>() => T;
}
