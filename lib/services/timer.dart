import 'dart:async';
import 'package:flutter/material.dart';

class TimerStore with ChangeNotifier {
  // TODO: ユーザーが設定できるように
  var count = 0;
  final sec = const Duration(seconds: 1);
  late Timer _timer;
  DateTime time = DateTime.utc(0, 0, 0);

  void startTimer() {
    _timer = Timer.periodic(sec, (timer) {
      time = time.add(sec);
    });
    notifyListeners();
  }

  void pauseTimer() {
    _timer.cancel();

    notifyListeners();
  }

  void stopTimer() {
    _timer.cancel();
    time = DateTime.utc(0, 0, 0);
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
