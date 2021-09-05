import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movement_measure/utilities/constants.dart';
import 'package:movement_measure/services/auth_service.dart';
import 'package:movement_measure/services/record_service.dart';
import 'package:movement_measure/services/timer.dart';
import 'package:movement_measure/screens/settings_screen.dart';
import 'package:movement_measure/screens/record_list_screen.dart';
import 'package:movement_measure/screens/comment_screem.dart';
import 'package:movement_measure/widgets/circle_button.dart';

class StartMeasurementScreen extends StatefulWidget {
  const StartMeasurementScreen({Key? key}) : super(key: key);

  @override
  State<StartMeasurementScreen> createState() => _StartMeasurementScreenState();
}

class _StartMeasurementScreenState extends State<StartMeasurementScreen> {
  @override
  Widget build(BuildContext context) {
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
        print(userId);
        recordService.setDocument(
            userId, timerStore.totalDistance, timerStore.time);
        recordService.saveDocument();
        timerStore.clearTimer();
      }
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 50.0,
              ),
              Text(
                '${timerStore.totalDistance} m',
                style: kMeasurementScreenTextStyle,
              ),
              Text(
                DateFormat.Hms().format(timerStore.time),
                style: kMeasurementScreenTextStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleButton(
                    // label: activityState.circleButtonLabel!,
                    label: timerStore.activityStatus.circleButtonLabel!,
                    buttonPrimaryColor: timerStore.activityStatus.activityColor,
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
              const SizedBox(
                height: 30.0,
              ),
              Container(
                width: 300,
                padding: EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: Color(0xAA1D1919),
                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          kPpageRouteBuilder(CommentScreen()),
                        );
                      },
                      iconSize: 40.0,
                      color: Colors.white,
                      icon: Icon(Icons.textsms_outlined),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          kPpageRouteBuilder(RecordListScreen()),
                        );
                      },
                      iconSize: 42.0,
                      color: Colors.white,
                      icon: Icon(Icons.history),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          kPpageRouteBuilder(SettingsScreen()),
                        );
                      },
                      iconSize: 42.0,
                      color: Colors.white,
                      icon: Icon(Icons.settings_outlined),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
