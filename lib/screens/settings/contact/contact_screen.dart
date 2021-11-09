import 'package:flutter/material.dart';
import 'package:movement_measure/utilities/constants.dart';
import 'package:movement_measure/screens/settings/settings_screen.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: kDefaultBlur,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                kPpageRouteBuilder(SettingsScreen()),
              );
            },
            iconSize: 30.0,
            icon: Icon(Icons.navigate_before),
          ),
          title: Text('Contact Us'),
        ),
        body: Container(),
      ),
    );
  }
}
