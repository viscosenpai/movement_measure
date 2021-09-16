import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'generated/l10n.dart';
import 'package:movement_measure/services/auth_service.dart';
import 'package:movement_measure/services/ad_state.dart';
import 'package:movement_measure/services/timer.dart';
import 'package:movement_measure/services/record_service.dart';
import 'package:movement_measure/screens/background_title_screen.dart';
import 'package:movement_measure/screens/start_measurement_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  // final adState = AdState(initFuture);
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthService.instance()),
      ChangeNotifierProvider(create: (_) => AdState(initFuture)),
      // Provider<AdState>.value(value: adState),
      ChangeNotifierProvider(create: (_) => TimerStore()),
      ChangeNotifierProvider(create: (_) => RecordService()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        // 翻訳テキストを呼び出す"S"クラスのデリゲートを登録
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: SignProcess(),
    );
  }
}

class SignProcess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, AuthService authService, _) {
        // ログインの状態に応じて処理を遷移させる。
        switch (authService.status) {
          case Status.uninitialized:
            print('uninitialized');
            return Center(child: BackgroundTitleScreen());
          case Status.unauthenticated:
          case Status.authenticating:
            print('anonymously');
            authService.signInAnonymously();
            return Center(child: BackgroundTitleScreen());
          case Status.authenticated:
            print("authenticated");
            break; // DbProcess();へ進む

        }
        return StackScreens();
      },
    );
  }
}

class StackScreens extends StatelessWidget {
  const StackScreens({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: const <Widget>[
        BackgroundTitleScreen(),
        StartMeasurementScreen(),
      ],
    );
  }
}
