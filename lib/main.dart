import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:movement_measure/app.dart';
import 'package:movement_measure/services/auth_service.dart';
import 'package:movement_measure/services/ad_state.dart';
import 'package:movement_measure/services/version_check_service.dart';
import 'package:movement_measure/services/timer_service.dart';
import 'package:movement_measure/services/record_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  await Firebase.initializeApp();
  final checker = await VersionCheckService();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthService.instance()),
      ChangeNotifierProvider(create: (_) => AdState(initFuture)),
      ChangeNotifierProvider(create: (_) => checker),
      ChangeNotifierProvider(create: (_) => TimerService()),
      ChangeNotifierProvider(create: (_) => RecordService()),
    ],
    child: App(),
  ));
}
