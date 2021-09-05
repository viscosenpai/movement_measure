import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:movement_measure/services/auth_service.dart';
import 'package:movement_measure/services/timer.dart';
import 'package:movement_measure/services/record_service.dart';
import 'package:movement_measure/screens/background_title_screen.dart';
import 'package:movement_measure/screens/start_measurement_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthService.instance()),
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
