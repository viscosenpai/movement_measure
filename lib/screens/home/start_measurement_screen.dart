import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:movement_measure/generated/l10n.dart';
import 'package:movement_measure/services/auth_service.dart';
import 'package:movement_measure/services/ad_state.dart';
import 'package:movement_measure/services/record_service.dart';
import 'package:movement_measure/services/timer_service.dart';
import 'package:movement_measure/services/geolocator_service.dart';
import 'package:movement_measure/widgets/circle_button.dart';
import 'package:movement_measure/widgets/navigation_button_area.dart';

class StartMeasurementScreen extends StatefulWidget {
  const StartMeasurementScreen({Key? key}) : super(key: key);

  @override
  State<StartMeasurementScreen> createState() => _StartMeasurementScreenState();
}

class _StartMeasurementScreenState extends State<StartMeasurementScreen> {
  late BannerAd banner;
  bool isLoadedBannerAd = false;
  GeolocatorService geolocator = GeolocatorService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
          adUnitId: adState.bannerAdUnitId,
          size: AdSize.fullBanner,
          request: AdRequest(),
          // listener: adState.adListener,
          listener: BannerAdListener(),
        )..load();
        isLoadedBannerAd = true;
      });
    });
  }

  @override
  void initState() {
    //
    Future.delayed(Duration.zero, () async {
      bool hasLocationPermission = await geolocator.hasLocationPermission();
      if (!hasLocationPermission) {
        showLocationDescriptionDialog(context);
      } else {
        geolocator.setStartPosition();
      }
    });
    super.initState();
  }

  Future<dynamic> showLocationDescriptionDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final btnLabel = "OK";
        return new AlertDialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white)),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
          title: Text(S.of(context).showLocationDescriptionTitle),
          contentTextStyle: TextStyle(fontSize: 18.0),
          content: Text(S.of(context).showLocationDescriptionBody),
          actions: <Widget>[
            TextButton(
              child: Text(
                btnLabel,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                geolocator.resolveLocationPermission();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final authService = Provider.of<AuthService>(context);
    final timerService = Provider.of<TimerService>(context);
    final recordService = Provider.of<RecordService>(context);
    recordService.uid = authService.user.uid;

    void countingTimer() {
      if (timerService.activityStatus == ActivityStatus.start) {
        recordService.initDocument(recordService.uid);
        timerService.startTimer();
      } else if (timerService.activityStatus == ActivityStatus.restart) {
        timerService.startTimer();
      } else if (timerService.activityStatus == ActivityStatus.pause) {
        timerService.pauseTimer();
      } else if (timerService.activityStatus == ActivityStatus.clear) {
        recordService.deleteDocument();
        timerService.clearTimer();
      }
    }

    void countingStop() {
      if (timerService.saveStatus == SaveStatus.stop &&
          timerService.activityStatus != ActivityStatus.start) {
        timerService.stopTimer();
      } else if (timerService.saveStatus == SaveStatus.save) {
        recordService.setDocument(
            recordService.uid, timerService.totalDistance, timerService.time);
        recordService.saveDocument();
        timerService.clearTimer();
      }
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 30.0,
                ),
                Text(
                  '${timerService.totalDistance} m',
                  style: TextStyle(
                    fontSize: 60.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  timerService.time,
                  style: TextStyle(
                    fontSize: 60.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.32,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleButton(
                        label: timerService.activityStatus.circleButtonLabel!,
                        buttonPrimaryColor:
                            timerService.activityStatus.activityColor,
                        buttonTextColor:
                            timerService.activityStatus.circleButtonTextColor,
                        onPressed: countingTimer,
                      ),
                      CircleButton(
                        label: timerService.saveStatus.circleButtonLabel!,
                        buttonPrimaryColor: timerService.saveStatus.saveColor,
                        buttonTextColor:
                            timerService.saveStatus.circleButtonTextColor,
                        onPressed: countingStop,
                      ),
                    ],
                  ),
                ),
                NavigationButtonArea(),
                if (isLoadedBannerAd)
                  Container(
                    height: 50,
                    child: AdWidget(ad: banner),
                  )
                else
                  SizedBox(
                    height: 50,
                  ),
                SizedBox(
                  height: 60.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
