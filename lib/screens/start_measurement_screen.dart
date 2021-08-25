import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:movement_measure/enum/activity_state.dart';
import 'package:movement_measure/services/geolocator.dart';
import 'package:movement_measure/widgets/circle_button.dart';

class StartMeasurementScreen extends StatefulWidget {
  const StartMeasurementScreen({Key? key}) : super(key: key);

  @override
  State<StartMeasurementScreen> createState() => _StartMeasurementScreenState();
}

class _StartMeasurementScreenState extends State<StartMeasurementScreen> {
  late Timer timer;
  late DateTime _time;
  ActivityState activityState = ActivityState.stop;

  late Map<String, double> startPosition = {};
  late Map<String, double> currentPosition = {};
  double addDistance = 0;
  double totalDistance = 0;

  void countingTimer() {
    if (activityState != ActivityState.during) {
      setState(() {
        activityState = ActivityState.during;
      });
      timer = Timer.periodic(
        Duration(seconds: 1),
        (Timer timer) {
          getCurrentPosition();
          setState(() {
            _time = _time.add(
              Duration(seconds: 1),
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
    }
  }

  void countingStop() {
    setState(() {
      print('called countingStop');
      activityState = ActivityState.stop;
      timer.cancel();
      // 表示時間を00:00:00に
      // TODO: 後々移動する
      _time = DateTime.utc(0, 0, 0);
      // 移動距離も0mに
      addDistance = 0;
      totalDistance = 0;
      // 初期位置を現在地に
      getStartPosition();
    });
  }

  void getStartPosition() async {
    GeolocatorService geolocator = GeolocatorService();
    try {
      var position = await geolocator.getDeterminePosition();
      startPosition['latitude'] = position.latitude;
      startPosition['longitude'] = position.longitude;
    } catch (e) {
      print(e);
    }
  }

  void getCurrentPosition() async {
    GeolocatorService geolocator = GeolocatorService();
    try {
      var position = await geolocator.getDeterminePosition();
      currentPosition['latitude'] = position.latitude;
      currentPosition['longitude'] = position.longitude;
      setDistance();
    } catch (e) {
      print(e);
    }
  }

  void setDistance() {
    // 距離計算
    GeolocatorService geolocator = GeolocatorService();
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

  @override
  void initState() {
    super.initState();
    _time = DateTime.utc(0, 0, 0);
    getStartPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '$totalDistance m',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                DateFormat.Hms().format(_time),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleButton(
                    activityState: activityState,
                    label: activityState.circleButtonLabel!,
                    onPressed: countingTimer,
                  ),
                  ElevatedButton(
                    onPressed: countingStop,
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      primary: Colors.orangeAccent,
                    ),
                    child: Container(
                      width: 150.0,
                      height: 150.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        'STOP',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
