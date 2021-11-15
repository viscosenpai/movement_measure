import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:movement_measure/utilities/constants.dart';
import 'package:movement_measure/services/auth_service.dart';
import 'package:movement_measure/services/ad_state.dart';
import 'package:movement_measure/services/record_service.dart';
import 'package:movement_measure/services/timer.dart';
import 'package:movement_measure/services/geolocator.dart';
import 'package:movement_measure/widgets/circle_button.dart';
import 'package:movement_measure/widgets/navigationButtonArea.dart';

class StartMeasurementScreen extends StatefulWidget {
  const StartMeasurementScreen({Key? key}) : super(key: key);

  @override
  State<StartMeasurementScreen> createState() => _StartMeasurementScreenState();
}

class _StartMeasurementScreenState extends State<StartMeasurementScreen> {
  late BannerAd banner;
  bool isLoadedBannerAd = false;
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
    GeolocatorService geolocator = GeolocatorService();
    geolocator.setStartPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final authService = Provider.of<AuthService>(context);
    final timerStore = Provider.of<TimerStore>(context);
    final recordService = Provider.of<RecordService>(context);
    String userId = authService.user.uid;
    recordService.uid = userId;

    void countingTimer() {
      if (timerStore.activityStatus == ActivityStatus.stop ||
          timerStore.activityStatus == ActivityStatus.pause) {
        recordService.initDocument(userId);
        timerStore.startTimer();
      } else if (timerStore.activityStatus == ActivityStatus.during) {
        timerStore.pauseTimer();
      } else if (timerStore.activityStatus == ActivityStatus.clear) {
        recordService.deleteDocument();
        timerStore.clearTimer();
      }
    }

    void countingStop() {
      if (timerStore.saveStatus == SaveStatus.stop &&
          timerStore.activityStatus != ActivityStatus.stop) {
        timerStore.stopTimer();
      } else if (timerStore.saveStatus == SaveStatus.save) {
        recordService.setDocument(
            userId, timerStore.totalDistance, timerStore.time);
        recordService.saveDocument();
        timerStore.clearTimer();
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
                  '${timerStore.totalDistance} m',
                  style: kMeasurementScreenTextStyle,
                ),
                Text(
                  DateFormat.Hms().format(timerStore.time),
                  style: kMeasurementScreenTextStyle,
                ),
                SizedBox(
                  height: deviceHeight * 0.32,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleButton(
                        // label: activityState.circleButtonLabel!,
                        label: timerStore.activityStatus.circleButtonLabel!,
                        buttonPrimaryColor:
                            timerStore.activityStatus.activityColor,
                        buttonTextColor:
                            timerStore.activityStatus.circleButtonTextColor,
                        onPressed: countingTimer,
                      ),
                      CircleButton(
                        label: timerStore.saveStatus.circleButtonLabel!,
                        buttonPrimaryColor: timerStore.saveStatus.saveColor,
                        buttonTextColor:
                            timerStore.saveStatus.circleButtonTextColor,
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
