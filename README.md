# Flutter Pagination Helper

Flutter pagination helper is used to reduce boilerplate code for pagination.

## Description

Here we have optimised concept of Model from model-view-intent pattern as described by [hannes dorfmann](http://hannesdorfmann.com/android/mosby3-mvi-1). So as a short note you can use this dependency for pagination by providing the state of model retrieved from your business logic. This state could be from progress bar visibility, data, error or data loading completion. Here to show paginated list you need to pass only list of widget as a data.

![custom_progress](https://cdn-images-1.medium.com/max/873/1*gd08OhXynqAR6TSeQY--2g.gif) ![default_progress](https://cdn-images-1.medium.com/max/873/1*2yJapvIy7fs7mJPpBv6zIw.gif)

## Implementation

To add flutter pagination helper dependency add following dependency in pubspec.yaml
```
dependencies:
  flutter_pagination_helper: ^1.0.1+2
```

### Common usage

* To use this dependency you have to assign `PaginatedListWidget` to the child of parent widget. In the code the prototype is mentioned to setup a paginated list. It can be retrived from `list_helper.dart` file.
* In parameter you can optionally assign `progressWidget` if you need to design your custom widget as progress. You can change color for default progress by assigning `colorSwatch` parameter to your parent material app theme.
* As 2nd parameter you have to assign `itemListCallback` which will be called each time user reach to end of listview. It can be retrived from `item_list_callback.dart` file.
```
import 'package:flutter_pagination_helper/pagination_helper/event_model.dart';
import 'package:flutter_pagination_helper/pagination_helper/item_list_callback.dart';
import 'package:flutter_pagination_helper/pagination_helper/list_helper.dart';

class CustomProgressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PaginatedListWidget(
            progressWidget: Center(
              child: Text("Loading..."),
            ),
            itemListCallback: OnScrollCallback()),
      ),
    );
  }
}
```
* In `itemListCallback` you have to implement your custom Callback as mentioned in code. It will return Future of generic type `EventModel`.
```
class OnScrollCallback<T extends Widget> extends ItemListCallback {
  @override
  Future<EventModel<T>> getItemList() {
    // TODO: implement getItemList
    return null;
  }
}
```
* `EventModel` is ui model to distinguish state as mentioned in code. It will be retrieved from `event_model.dart` file.
  - Here `progress` indicates the visibility of progress bar while loading item.
  - `data` will be list of widgets which will be displayed in list view. [Note : This field will contain items which are not retrieved on previous call].
  - `error` is a error message when api fails and it will be displayed as SnackBar.
  - `stopLoading` will be true when all items are retrieved and we need to stop pagination.
```
class EventModel<T extends Widget> {
  final bool progress;
  final List<T> data;
  final String error;
  final bool stopLoading;

  EventModel({this.progress, this.data, this.error, this.stopLoading});
}

```
* Get the clear understanding for flutter pagination from this [article](https://medium.com/@AakashDMehta/paginate-your-data-in-flutter-7744995febd1).
* You can refer following demo for different perspactive.
  * [Pagination with default progress widget.](https://github.com/akashMehta-STL/FlutterPaginationHelper/blob/master/lib/demo/default_progress_pagination.dart)
  * [Pagination with custom progress widget.](https://github.com/akashMehta-STL/FlutterPaginationHelper/blob/master/lib/demo/custom_progress_pagination.dart)
  * [Pagination with error message.](https://github.com/akashMehta-STL/FlutterPaginationHelper/blob/master/lib/demo/pagination_error.dart)
  * [Pagination implemented with hacker rank api integration.](https://github.com/akashMehta-STL/FlutterPaginationHelper/tree/master/lib/demo/hackerNewsIntegration)
- [Flutter pagination helper](https://pub.dartlang.org/packages/flutter_pagination_helper#-installing-tab-)
- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
