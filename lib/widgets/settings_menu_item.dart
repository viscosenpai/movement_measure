import 'package:flutter/material.dart';
import 'package:movement_measure/utilities/constants.dart';

class SettingsMenuItem extends StatelessWidget {
  const SettingsMenuItem({
    Key? key,
    required this.menuTitle,
    required this.menuIcon,
    required this.pushedScreen,
    this.ispushed = true,
  }) : super(key: key);

  final String menuTitle;
  final IconData menuIcon;
  final bool ispushed;
  final Widget pushedScreen;

  @override
  Widget build(BuildContext context) {
    if (ispushed) {
      return pushedMenu(
          pushedScreen: pushedScreen, menuIcon: menuIcon, menuTitle: menuTitle);
    } else {
      return versionMenu(menuIcon: menuIcon, menuTitle: menuTitle);
    }
  }
}

class versionMenu extends StatelessWidget {
  const versionMenu({
    Key? key,
    required this.menuIcon,
    required this.menuTitle,
  }) : super(key: key);

  final IconData menuIcon;
  final String menuTitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        menuIcon,
        color: Colors.white,
        size: 30.0,
      ),
      title: Text(
        menuTitle,
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
      trailing: Text("1.0.0"),
    );
  }
}

class pushedMenu extends StatelessWidget {
  const pushedMenu({
    Key? key,
    required this.pushedScreen,
    required this.menuIcon,
    required this.menuTitle,
  }) : super(key: key);

  final Widget pushedScreen;
  final IconData menuIcon;
  final String menuTitle;

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
        leading: Icon(
          menuIcon,
          color: Colors.white,
          size: 30.0,
        ),
        title: Text(
          menuTitle,
          style: TextStyle(fontSize: 20.0),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.white,
          size: 30.0,
        ),
      ),
    );
  }
}
