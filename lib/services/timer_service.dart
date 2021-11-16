import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movement_measure/services/geolocator_service.dart';
import 'package:movement_measure/utilities/constants.dart';

enum ActivityStatus {
  start,
  pause,
  restart,
  clear,
}

extension ActivityExtension on ActivityStatus {
  static final Map<ActivityStatus, Color?> activityColors = {
    ActivityStatus.start: kStartButtonColor,
    ActivityStatus.pause: kPauseButtonColor,
    ActivityStatus.restart: kRestartClearButtonColor,
    ActivityStatus.clear: kRestartClearButtonColor,
  };

  Color? get activityColor => activityColors[this];

  static final Map<ActivityStatus, String> circleButtonLabels = {
    ActivityStatus.start: 'START',
    ActivityStatus.pause: 'PAUSE',
    ActivityStatus.restart: 'RESTART',
    ActivityStatus.clear: 'CLEAR',
  };

  String? get circleButtonLabel => circleButtonLabels[this];

  static final Map<ActivityStatus, Color?> circleButtonTextColors = {
    ActivityStatus.start: kDefaultButtonTextColor,
    ActivityStatus.pause: kDefaultButtonTextColor,
    ActivityStatus.restart: kReversalButtonTextColor,
    ActivityStatus.clear: kReversalButtonTextColor,
  };

  Color? get circleButtonTextColor => circleButtonTextColors[this];
}

enum SaveStatus {
  stop,
  save,
}

extension SaveExtension on SaveStatus {
  static final Map<SaveStatus, Color?> saveColors = {
    SaveStatus.stop: kStopButtonColor,
    SaveStatus.save: kSaveButtonColor,
  };

  Color? get saveColor => saveColors[this];

  static final Map<SaveStatus, String> circleButtonLabels = {
    SaveStatus.stop: 'STOP',
    SaveStatus.save: 'SAVE',
  };

  String? get circleButtonLabel => circleButtonLabels[this];

  static final Map<SaveStatus, Color?> circleButtonTextColors = {
    SaveStatus.stop: kDefaultButtonTextColor,
    SaveStatus.save: kDefaultButtonTextColor,
  };

  Color? get circleButtonTextColor => circleButtonTextColors[this];
}

class TimerService with ChangeNotifier {
  var count = 0;
  final sec = const Duration(seconds: 1);

  // TODO: ユーザーが設定できるように
  int _addDistanceCount = kDefaultAddDistanceCount;

  late Timer _timer;
  DateTime _time = kInitialDateTime;

  GeolocatorService geolocator = GeolocatorService();
  double totalDistance = 0;

  ActivityStatus _activityStatus = ActivityStatus.start;
  SaveStatus _saveStatus = SaveStatus.stop;

  ActivityStatus get activityStatus => _activityStatus;
  SaveStatus get saveStatus => _saveStatus;
  String get time => DateFormat.Hms().format(_time);

  int get addDistanceCount => _addDistanceCount;

  void startTimer() {
    _activityStatus = ActivityStatus.pause;
    geolocator.setStartPosition();
    _timer = Timer.periodic(sec, (timer) {
      resetAddDistanceCount();
      _time = _time.add(sec);
    });
    notifyListeners();
  }

  void pauseTimer() {
    _activityStatus = ActivityStatus.restart;
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
    _activityStatus = ActivityStatus.start;
    _saveStatus = SaveStatus.stop;
    _time = kInitialDateTime;
    _addDistanceCount = kDefaultAddDistanceCount;
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
    var distance =
        double.parse(geolocator.getBetweenDistance().toStringAsFixed(2));
    print(distance);
    totalDistance += distance;
    print(totalDistance);
    geolocator.eliminateDistance();
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
