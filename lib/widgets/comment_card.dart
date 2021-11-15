import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  CommentCard({
    Key? key,
    required dynamic this.comment,
  }) : super(key: key);

  final dynamic comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16.0, bottom: 18.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.5, color: Colors.grey),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            '${comment.commentTime}',
            style: TextStyle(color: Colors.orange[300], fontSize: 20.0),
          ),
          Text(
            '${comment.comment}',
            style: TextStyle(fontSize: 20.0),
          ),
        ],
      ),
    );
  }
}
