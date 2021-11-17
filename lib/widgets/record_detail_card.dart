import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:movement_measure/services/record_service.dart';
import 'package:movement_measure/widgets/comment_card.dart';
import 'package:movement_measure/widgets/message_box.dart';
import 'package:movement_measure/widgets/loader.dart';

class RecordDetailCard extends StatelessWidget {
  const RecordDetailCard({
    Key? key,
    required this.splitDate,
    required this.recordService,
    required this.id,
  }) : super(key: key);

  final List<String> splitDate;
  final RecordService recordService;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0x99000000),
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            '${splitDate[0]}',
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 20.0),
          ),
          Text(
            '${splitDate[1]}',
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                color: Colors.white,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${recordService.record["movementTime"]}',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${recordService.record["movementDistance"]} m',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                GetCommentDataStream(docId: id),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GetCommentDataStream extends StatelessWidget {
  GetCommentDataStream({Key? key, required this.docId}) : super(key: key);

  final String docId;

  Widget build(BuildContext context) {
    final recordService = Provider.of<RecordService>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: recordService.getCommentStream(docId),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return MessageBox(message: 'Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loader();
        }

        if (snapshot.hasData) {
          recordService.initComment(snapshot.data!.docs);
        }

        var commentCards = recordService.comments.map((comment) {
          return CommentCard(comment: comment);
        }).toList();

        return Column(
          children: commentCards,
        );
      },
    );
  }
}
