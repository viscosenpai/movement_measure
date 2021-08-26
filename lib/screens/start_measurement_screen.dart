import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:movement_measure/utilities/constants.dart';
import 'package:movement_measure/enum/activity_state.dart';
import 'package:movement_measure/enum/save_state.dart';
import 'package:movement_measure/services/geolocator.dart';
import 'package:movement_measure/widgets/circle_button.dart';

class StartMeasurementScreen extends StatefulWidget {
  const StartMeasurementScreen({Key? key}) : super(key: key);

  @override
  State<StartMeasurementScreen> createState() => _StartMeasurementScreenState();
}

class _StartMeasurementScreenState extends State<StartMeasurementScreen> {
  late Timer timer;
  DateTime _time = DateTime.utc(0, 0, 0);
  Duration second = const Duration(seconds: 1);
  ActivityState activityState = ActivityState.stop;
  SaveState saveState = SaveState.stop;
  GeolocatorService geolocator = GeolocatorService();

  late Map<String, double> startPosition = {};
  late Map<String, double> currentPosition = {};
  double addDistance = 0;
  double totalDistance = 0;

  void countingTimer() {
    if (activityState == ActivityState.stop ||
        activityState == ActivityState.pause) {
      setState(() {
        activityState = ActivityState.during;
      });
      timer = Timer.periodic(
        second,
        (Timer timer) {
          getCurrentPosition(currentPosition);
          setState(() {
            _time = _time.add(
              second,
            );
          });
        },
      );
    } else if (activityState == ActivityState.during) {
      setState(() {
        activityState = ActivityState.pause;
        if (timer.isActive) {
          timer.cancel();
        }
      });
    } else if (activityState == ActivityState.clear) {
      setState(() {
        activityState = ActivityState.stop;
        saveState = SaveState.stop;
        clearLog();
      });
    }
  }

  void countingStop() {
    if (saveState == SaveState.stop && activityState != ActivityState.stop) {
      setState(() {
        activityState = ActivityState.clear;
        saveState = SaveState.save;
        timer.cancel();
      });
    } else if (saveState == SaveState.save) {
      setState(() {
        activityState = ActivityState.stop;
        saveState = SaveState.stop;
        // 時間と距離を記録
        clearLog();
      });
    }
  }

  void getCurrentPosition(Map<String, double> onSetPosition) async {
    try {
      var position = await geolocator.getDeterminePosition();
      onSetPosition['latitude'] = position.latitude;
      onSetPosition['longitude'] = position.longitude;
    } catch (e) {
      print(e);
    }
  }

  void setDistance() {
    // 距離計算
    var distance = geolocator.getBetweenDistance(
      startPosition['latitude'],
      startPosition['longitude'],
      currentPosition['latitude'],
      currentPosition['longitude'],
    );
    print(distance);
    print(addDistance);
    addDistance += distance;
    setState(() {
      totalDistance = double.parse(addDistance.toStringAsFixed(2));
    });
  }

  void clearLog() {
    // 表示時間を00:00:00に
    _time = DateTime.utc(0, 0, 0);
    // 移動距離も0mに
    addDistance = 0;
    totalDistance = 0;
    // 初期位置を現在地に
    getCurrentPosition(startPosition);
  }

  @override
  void initState() {
    super.initState();
    // 現在地を取得
    getCurrentPosition(currentPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 50.0,
              ),
              Text(
                '$totalDistance m',
                style: kMeasurementScreenTextStyle,
              ),
              Text(
                DateFormat.Hms().format(_time),
                style: kMeasurementScreenTextStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleButton(
                    label: activityState.circleButtonLabel!,
                    buttonPrimaryColor: activityState.activityColor,
                    buttonTextColor: activityState.circleButtonTextColor,
                    onPressed: countingTimer,
                  ),
                  CircleButton(
                    label: saveState.circleButtonLabel!,
                    buttonPrimaryColor: saveState.saveColor,
                    buttonTextColor: saveState.circleButtonTextColor,
                    onPressed: countingStop,
                  ),
                ],
              ),
              const SizedBox(
                height: 100.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
