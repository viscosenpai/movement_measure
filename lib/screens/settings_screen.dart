import 'package:flutter/material.dart';
import 'package:movement_measure/widgets/backdrop_base_sheet.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropBaseSheet(
      sheetTitle: 'Settings',
      bodyComponent: SettingsMenuList(),
    );
  }
}

class SettingsMenuList extends StatelessWidget {
  const SettingsMenuList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 7,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {},
          child: ListTile(
            leading: Icon(Icons.home, color: Colors.white, size: 30.0),
            title: Text(
              'Menu1',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
              ),
            ),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Colors.white, size: 30.0),
          ),
        );
      },
    );
  }
}
