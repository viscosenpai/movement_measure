import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
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
      sheetTitle: 'Comment',
      bodyComponent: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  setState(() {
                    comment = value;
                  });
                  print(comment);
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
              print(recordService.docId);
              print(timerStore.time);
              print(comment);
              recordService.addComment(recordService.docId, {
                'comment': comment,
                'commentTime': DateFormat.Hms().format(timerStore.time),
              });
            }
          },
          child: Text(
            'add',
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
