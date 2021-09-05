import 'dart:ui';
import 'package:flutter/material.dart';

class BackdropBaseSheet extends StatelessWidget {
  BackdropBaseSheet({
    Key? key,
    required this.sheetTitle,
    required this.bodyComponent,
    this.actions,
  }) : super(key: key);

  final String sheetTitle;
  final Widget? bodyComponent;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.black54,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 30.0,
              icon: Icon(Icons.close),
            ),
            title: Text('$sheetTitle'),
            actions: actions,
          ),
          body: bodyComponent,
        ),
      ),
    );
  }
}
