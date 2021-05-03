part of pagination_helper;

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
    BlocProvider<T> blocProvider = context.findAncestorWidgetOfExactType<BlocProvider<T>>()!;

    return blocProvider.bloc;
  }

  BlocProvider({Key? key, required this.bloc, required this.child})
      : super(key: key);

  static Type typeOf<T>() => T;
}
