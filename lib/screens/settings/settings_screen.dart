import 'package:flutter/material.dart';
import 'package:movement_measure/generated/l10n.dart';
import 'package:movement_measure/screens/settings/about/about_screen.dart';
import 'package:movement_measure/widgets/backdrop_base_sheet.dart';
import 'package:movement_measure/widgets/settingsMenuItem.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropBaseSheet(
      sheetTitle: S.of(context).settings,
      bodyComponent: SettingsMenuList(),
    );
  }
}

class SettingsMenuList extends StatelessWidget {
  const SettingsMenuList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List titleList = [
      '',
      '',
      '',
      '',
      'Share',
      // 'Contact Us',
      S.of(context).aboutMenuTitle,
    ];

    List iconList = [
      Icons.home,
      Icons.home,
      Icons.home,
      Icons.home,
      Icons.share_outlined,
      // Icons.email,
      Icons.straighten,
    ];

    List pushedScreenList = [
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
      // ContactScreen(),
      AboutScreen(),
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
