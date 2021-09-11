import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movement_measure/utilities/constants.dart';
import 'package:movement_measure/screens/settings/settings_screen.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          elevation: 0,
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
