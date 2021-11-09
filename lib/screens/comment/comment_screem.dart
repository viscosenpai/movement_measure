import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:movement_measure/generated/l10n.dart';
import 'package:movement_measure/services/timer.dart';
import 'package:movement_measure/services/record_service.dart';
import 'package:movement_measure/widgets/backdrop_base_sheet.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  String comment = '';

  @override
  Widget build(BuildContext context) {
    final timerStore = Provider.of<TimerStore>(context);
    final recordService = Provider.of<RecordService>(context);

    return BackdropBaseSheet(
      sheetTitle: S.of(context).comment,
      bodyComponent: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  setState(() {
                    comment = value;
                  });
                },
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                cursorColor: Colors.white,
                scrollPadding: EdgeInsets.all(20.0),
                keyboardType: TextInputType.multiline,
                maxLength: 400,
                maxLines: 999,
                autofocus: true,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (comment.length != 0 &&
                timerStore.activityStatus != ActivityStatus.stop &&
                timerStore.saveStatus != SaveStatus.save) {
              recordService.addComment(recordService.docId, {
                'comment': comment,
                'commentTime': DateFormat.Hms().format(timerStore.time),
              });
              Navigator.pop(context);
            } else {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  final message = S.of(context).commentValidMessage;
                  final btnLabel = "OK";
                  return new AlertDialog(
                    backgroundColor: Colors.black54,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white)),
                    contentTextStyle:
                        TextStyle(color: Colors.white, fontSize: 18.0),
                    content: Text(message),
                    actions: <Widget>[
                      TextButton(
                        child: Text(
                          btnLabel,
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () => {Navigator.pop(context)},
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Text(
            S.of(context).add,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
      ],
    );
  }
}
