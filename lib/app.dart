import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'generated/l10n.dart';
import 'package:movement_measure/services/auth_service.dart';
import 'package:movement_measure/screens/home/home.dart';
import 'package:movement_measure/screens/home/background_title_screen.dart';
import 'package:movement_measure/widgets/introduction_pages.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        // 翻訳テキストを呼び出す"S"クラスのデリゲートを登録
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
          backgroundColor: Colors.black54,
          elevation: 0,
        ),
        scaffoldBackgroundColor: Color(0x99000000),
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(
          Theme.of(context).textTheme.copyWith(
                subtitle1: TextStyle(color: Colors.white),
                subtitle2: TextStyle(color: Colors.white),
                bodyText1: TextStyle(color: Colors.white),
                bodyText2: TextStyle(color: Colors.white),
              ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      home: SignProcess(),
    );
  }
}

class SignProcess extends StatefulWidget {
  @override
  _SignProcessState createState() => _SignProcessState();
}

class _SignProcessState extends State<SignProcess> {
  bool isDoneTutorial = false;

  void _showIntroductionPages(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();

    if (pref.getBool('isAlreadyFirstLaunch') != true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IntroductionPages(
            onDone: () {
              setState(() {
                isDoneTutorial = true;
              });
              Navigator.pop(context);
            },
          ),
          fullscreenDialog: true,
        ),
      );
      pref.setBool('isAlreadyFirstLaunch', true);
    } else {
      setState(() {
        isDoneTutorial = true;
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => _showIntroductionPages(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('isDoneTutorial: $isDoneTutorial');
    if (isDoneTutorial) {
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
              break;
          }
          return Home();
        },
      );
    } else {
      return Container();
    }
  }
}
