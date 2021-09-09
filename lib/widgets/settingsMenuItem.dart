import 'package:flutter/material.dart';
import 'package:movement_measure/utilities/constants.dart';

class SettingsMenuItem extends StatelessWidget {
  const SettingsMenuItem({
    Key? key,
    required this.menuTitle,
    required this.menuIcon,
    required this.pushedScreen,
  }) : super(key: key);

  final String menuTitle;
  final IconData menuIcon;
  final Widget pushedScreen;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          kPpageRouteBuilder(pushedScreen),
        );
      },
      child: ListTile(
        leading: Icon(menuIcon, color: Colors.white, size: 30.0),
        title: Text(
          menuTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
      ),
    );
  }
}
