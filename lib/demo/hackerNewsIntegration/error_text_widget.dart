import 'package:flutter/material.dart';

class ErrorTextWidget extends StatelessWidget {
  final String message;

  ErrorTextWidget(this.message);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(color: Colors.red, fontSize: 12),
      ),
    );
  }
}
