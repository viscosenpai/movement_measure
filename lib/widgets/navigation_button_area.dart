import 'package:flutter/material.dart';
import 'package:movement_measure/utilities/constants.dart';
import 'package:movement_measure/screens/settings/settings_screen.dart';
import 'package:movement_measure/screens/records/record_list_screen.dart';
import 'package:movement_measure/screens/comment/comment_screem.dart';

class NavigationButtonArea extends StatelessWidget {
  const NavigationButtonArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void pushedSubPage(Widget subPage) {
      Navigator.push(
        context,
        kPpageRouteBuilder(subPage),
      );
    }

    return Container(
      width: 300,
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        border: Border.all(color: Colors.grey, width: 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            onPressed: () {
              pushedSubPage(CommentScreen());
            },
            iconSize: 40.0,
            color: Colors.white,
            icon: Icon(Icons.textsms_outlined),
          ),
          IconButton(
            onPressed: () {
              pushedSubPage(RecordListScreen());
            },
            iconSize: 42.0,
            color: Colors.white,
            icon: Icon(Icons.history),
          ),
          IconButton(
            onPressed: () {
              pushedSubPage(SettingsScreen());
            },
            iconSize: 42.0,
            color: Colors.white,
            icon: Icon(Icons.settings_outlined),
          ),
        ],
      ),
    );
  }
}
