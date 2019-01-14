import 'package:flutter/material.dart';

class ProgressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          backgroundColor: Colors.teal,
          strokeWidth: 3,
        ),
      ),
    );
  }
}
