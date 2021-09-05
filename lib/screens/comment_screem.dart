import 'package:flutter/material.dart';
import 'package:movement_measure/widgets/backdrop_base_sheet.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String comment = '';
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
                  comment = value;
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
            if (comment.length != 0) {
              print(comment);
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
