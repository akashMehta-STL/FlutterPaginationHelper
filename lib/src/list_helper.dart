part of pagination_helper;

class PaginatedListWidget extends StatelessWidget {
  final ItemListCallback itemListCallback;
  final Widget progressWidget;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  PaginatedListWidget({required this.progressWidget, required this.itemListCallback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: BlocProvider(
          bloc: PaginationBloc(itemListCallback: itemListCallback),
          child: ListWidget(
            progressWidget: progressWidget,
            scaffoldKey: scaffoldKey,
          )),
    );
  }
}
