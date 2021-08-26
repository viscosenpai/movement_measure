import 'package:flutter/material.dart';

enum SaveState {
  stop,
  save,
}

extension SaveExtension on SaveState {
  static final Map<SaveState, Color?> saveColors = {
    SaveState.stop: Colors.orange,
    SaveState.save: Colors.blueGrey,
  };

  Color? get saveColor => saveColors[this];

  static final Map<SaveState, String> circleButtonLabels = {
    SaveState.stop: 'STOP',
    SaveState.save: 'SAVE',
  };

  String? get circleButtonLabel => circleButtonLabels[this];

  static final Map<SaveState, Color?> circleButtonTextColors = {
    SaveState.stop: Colors.white,
    SaveState.save: Colors.white,
  };

  Color? get circleButtonTextColor => circleButtonTextColors[this];
}
