import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:movement_measure/services/record_service.dart';
import 'package:provider/provider.dart';
import 'package:movement_measure/utilities/constants.dart';
import 'package:movement_measure/enum/activity_state.dart';
import 'package:movement_measure/enum/save_state.dart';
import 'package:movement_measure/services/geolocator.dart';
import 'package:movement_measure/services/auth_service.dart';
import 'package:movement_measure/screens/settings_screen.dart';
import 'package:movement_measure/screens/record_list_screen.dart';
import 'package:movement_measure/screens/comment_screem.dart';
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
  int addDistanceCount = 5;
  ActivityState activityState = ActivityState.stop;
  SaveState saveState = SaveState.stop;
  GeolocatorService geolocator = GeolocatorService();

  double addDistance = 0;
  double totalDistance = 0;

  late String userId;

  void setDistance() async {
    await geolocator.setCurrntPosition();
    // 距離計算
    var distance = geolocator.getBetweenDistance();
    print(distance);
    print(addDistance);
    addDistance += distance;
    geolocator.eliminateDistance();
    setState(() {
      totalDistance = double.parse(addDistance.toStringAsFixed(2));
    });
  }

  void setInitialPosition() {
    geolocator.setStartPosition();
  }

  void clearLog() {
    // 表示時間を00:00:00に
    _time = DateTime.utc(0, 0, 0);
    addDistanceCount = 5;
    // 移動距離も0mに
    addDistance = 0;
    totalDistance = 0;
    // 初期位置を現在地に
    setInitialPosition();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final recordService = Provider.of<RecordService>(context);
    userId = authService.user.uid;
    recordService.uid = userId;

    void countingTimer() {
      if (activityState == ActivityState.stop ||
          activityState == ActivityState.pause) {
        setState(() {
          activityState = ActivityState.during;
        });
        recordService.initDocument(userId);
        setInitialPosition();
        timer = Timer.periodic(
          second,
          (Timer timer) {
            if (addDistanceCount == 0) {
              setDistance();
              addDistanceCount = 5;
            }
            addDistanceCount--;
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
        recordService.deleteDocument();
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
        activityState = ActivityState.stop;
        saveState = SaveState.stop;
        print(totalDistance);
        print(_time);
        print(userId);
        recordService.setDocument(userId, totalDistance, _time);
        recordService.saveDocument();
        setState(() {
          clearLog();
        });
        print(recordService.record);
      }
    }

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
                height: 30.0,
              ),
              Container(
                width: 300,
                padding: EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: Color(0xAA1D1919),
                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          kPpageRouteBuilder(CommentScreen()),
                        );
                      },
                      iconSize: 40.0,
                      color: Colors.white,
                      icon: Icon(Icons.textsms_outlined),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          kPpageRouteBuilder(RecordListScreen()),
                        );
                      },
                      iconSize: 42.0,
                      color: Colors.white,
                      icon: Icon(Icons.history),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          kPpageRouteBuilder(SettingsScreen()),
                        );
                      },
                      iconSize: 42.0,
                      color: Colors.white,
                      icon: Icon(Icons.settings_outlined),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
