import 'package:flutter/material.dart';
import 'package:movement_measure/utilities/constants.dart';

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
      filter: kDefaultBlur,
      child: Container(
        child: Scaffold(
          appBar: AppBar(
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
