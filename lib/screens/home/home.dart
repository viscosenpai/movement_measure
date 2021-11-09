import 'package:flutter/material.dart';
import 'package:movement_measure/screens/home/background_title_screen.dart';
import 'package:movement_measure/screens/home/start_measurement_screen.dart';
import 'package:movement_measure/widgets/updater.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        BackgroundTitleScreen(),
        StartMeasurementScreen(),
        Updater(),
      ],
    );
  }
}
