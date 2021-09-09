import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movement_measure/utilities/constants.dart';
import 'package:movement_measure/screens/settings/settings_screen.dart';
import 'package:movement_measure/screens/settings/about/how_to_use_screen.dart';
import 'package:movement_measure/widgets/settingsMenuItem.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

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
          title: Text('About MovementMeasure'),
        ),
        body: AboutMenuList(),
      ),
    );
  }
}

class AboutMenuList extends StatelessWidget {
  const AboutMenuList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List titleList = [
      'How to use',
      'Terms of service',
      'Privacy policy',
    ];

    List iconList = [
      Icons.info_outline,
      Icons.person_outline,
      Icons.privacy_tip_outlined,
    ];

    List pushedScreenList = [
      HowToUseScreen(),
      Container(),
      Container(),
    ];

    return ListView.builder(
      itemCount: titleList.length,
      itemBuilder: (context, index) {
        return SettingsMenuItem(
          menuTitle: titleList[index],
          menuIcon: iconList[index],
          pushedScreen: pushedScreenList[index],
        );
      },
    );
  }
}
