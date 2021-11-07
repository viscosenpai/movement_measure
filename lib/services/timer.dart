import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movement_measure/services/geolocator.dart';
import 'package:movement_measure/utilities/constants.dart';

enum ActivityStatus {
  stop,
  during,
  pause,
  clear,
}

extension ActivityExtension on ActivityStatus {
  static final Map<ActivityStatus, Color?> activityColors = {
    ActivityStatus.stop: Colors.orange[900],
    ActivityStatus.during: Colors.blueGrey,
    ActivityStatus.pause: Colors.white,
    ActivityStatus.clear: Colors.white,
  };

  Color? get activityColor => activityColors[this];

  static final Map<ActivityStatus, String> circleButtonLabels = {
    ActivityStatus.stop: 'START',
    ActivityStatus.during: 'PAUSE',
    ActivityStatus.pause: 'RESTART',
    ActivityStatus.clear: 'CLEAR',
  };

  String? get circleButtonLabel => circleButtonLabels[this];

  static final Map<ActivityStatus, Color?> circleButtonTextColors = {
    ActivityStatus.stop: Colors.white,
    ActivityStatus.during: Colors.white,
    ActivityStatus.pause: Colors.orange[900],
    ActivityStatus.clear: Colors.orange[900],
  };

  Color? get circleButtonTextColor => circleButtonTextColors[this];
}

enum SaveStatus {
  stop,
  save,
}

extension SaveExtension on SaveStatus {
  static final Map<SaveStatus, Color?> saveColors = {
    SaveStatus.stop: Colors.orange,
    SaveStatus.save: Colors.blueGrey,
  };

  Color? get saveColor => saveColors[this];

  static final Map<SaveStatus, String> circleButtonLabels = {
    SaveStatus.stop: 'STOP',
    SaveStatus.save: 'SAVE',
  };

  String? get circleButtonLabel => circleButtonLabels[this];

  static final Map<SaveStatus, Color?> circleButtonTextColors = {
    SaveStatus.stop: Colors.white,
    SaveStatus.save: Colors.white,
  };

  Color? get circleButtonTextColor => circleButtonTextColors[this];
}

class TimerStore with ChangeNotifier {
  var count = 0;
  final sec = const Duration(seconds: 1);

  // TODO: ユーザーが設定できるように
  int _addDistanceCount = kDefaultAddDistanceCount;

  late Timer _timer;
  DateTime _time = DateTime.utc(0, 0, 0);

  GeolocatorService geolocator = GeolocatorService();
  double addDistance = 0;
  double totalDistance = 0;

  ActivityStatus _activityStatus = ActivityStatus.stop;
  SaveStatus _saveStatus = SaveStatus.stop;

  ActivityStatus get activityStatus => _activityStatus;
  SaveStatus get saveStatus => _saveStatus;
  DateTime get time => _time;

  int get addDistanceCount => _addDistanceCount;

  void startTimer() {
    _activityStatus = ActivityStatus.during;
    geolocator.setStartPosition();
    _timer = Timer.periodic(sec, (timer) {
      resetAddDistanceCount();
      _time = _time.add(sec);
    });
    notifyListeners();
  }

  void pauseTimer() {
    _activityStatus = ActivityStatus.pause;
    if (_timer.isActive) {
      _timer.cancel();
    }
    notifyListeners();
  }

  void stopTimer() {
    _activityStatus = ActivityStatus.clear;
    _saveStatus = SaveStatus.save;
    _timer.cancel();
    notifyListeners();
  }

  void clearTimer() {
    _activityStatus = ActivityStatus.stop;
    _saveStatus = SaveStatus.stop;
    _time = DateTime.utc(0, 0, 0);
    _addDistanceCount = kDefaultAddDistanceCount;
    addDistance = 0;
    totalDistance = 0;
    geolocator.setStartPosition();
    notifyListeners();
  }

  void resetAddDistanceCount() {
    if (_addDistanceCount == 0) {
      setDistance();
      _addDistanceCount = kDefaultAddDistanceCount;
    }
    _addDistanceCount--;
    notifyListeners();
  }

  void setDistance() async {
    await geolocator.setCurrntPosition();
    // 距離計算
    var distance = geolocator.getBetweenDistance();
    print(distance);
    print(addDistance);
    addDistance += distance;
    geolocator.eliminateDistance();
    totalDistance = double.parse(addDistance.toStringAsFixed(2));
    notifyListeners();
  }

  void updateCounter() {
    if (count > 0)
      count--;
    else
      _timer.cancel();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
