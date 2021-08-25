import 'package:flutter/material.dart';

enum ActivityState {
  stop,
  during,
  pause,
}

extension ActivityExtension on ActivityState {
  static final Map<ActivityState, Color?> activityColors = {
    ActivityState.stop: Colors.orange[900],
    ActivityState.during: Colors.blueGrey,
    ActivityState.pause: Colors.white,
  };

  Color? get activityColor => activityColors[this];

  static final Map<ActivityState, String> circleButtonLabels = {
    ActivityState.stop: 'START',
    ActivityState.during: 'PAUSE',
    ActivityState.pause: 'RESTART',
  };

  String? get circleButtonLabel => circleButtonLabels[this];

  static final Map<ActivityState, Color?> circleButtonTextColors = {
    ActivityState.stop: Colors.white,
    ActivityState.during: Colors.white,
    ActivityState.pause: Colors.orange[900],
  };

  Color? get circleButtonTextColor => circleButtonTextColors[this];
}
