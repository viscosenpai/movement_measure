import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

const String DEV_VERSION_CONFIG = "dev_app_version";
const String CONFIG_VERSION = "force_update_app_version";

// releaseビルドかどうかで取得するconfig名を変更
final configName = bool.fromEnvironment('dart.vm.product')
    ? CONFIG_VERSION
    : DEV_VERSION_CONFIG;

const kMeasurementScreenTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 60.0,
  fontWeight: FontWeight.bold,
);

String kDefaultMovementTime = DateFormat.Hms().format(DateTime.utc(0, 0, 0));

PageRouteBuilder<dynamic> kPpageRouteBuilder(Widget widget) {
  return PageRouteBuilder(
    opaque: false,
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return widget;
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(0.0, 0.0),
          ).animate(secondaryAnimation),
          child: child,
        ),
      );
    },
  );
}
