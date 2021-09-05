import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:movement_measure/services/record_service.dart';
import 'package:movement_measure/screens/record_list_screen.dart';
import 'package:movement_measure/utilities/constants.dart';

class RecordDetailScreen extends StatelessWidget {
  const RecordDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                kPpageRouteBuilder(RecordListScreen()),
              );
            },
            iconSize: 30.0,
            icon: Icon(Icons.navigate_before),
          ),
          title: Text('Detail'),
        ),
        body: RecordDetail(id: id),
      ),
    );
  }
}

class RecordDetail extends StatelessWidget {
  const RecordDetail({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    final recordService = Provider.of<RecordService>(context);

    return FutureBuilder<DocumentSnapshot>(
      future: recordService.getRecordDetail(id),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          recordService.initDetail(snapshot);
          final dateTime = recordService
              .toDateTimeString(recordService.record['recordDate']);

          return Container(
            color: Color(0x99000000),
            margin: EdgeInsets.all(8.0),
            padding:
                EdgeInsets.only(top: 8.0, right: 8.0, bottom: 8.0, left: 62.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  '$dateTime',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${recordService.record["movementTime"]}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                    ),
                    Text(
                      '${recordService.record["movementDistance"]} m',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                _getCommentData(docId: id),
              ],
            ),
          );
        }

        return Text("loading");
      },
    );
  }
}

class _getCommentData extends StatelessWidget {
  _getCommentData({Key? key, required this.docId}) : super(key: key);

  final String docId;

  Widget build(BuildContext context) {
    final recordService = Provider.of<RecordService>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: recordService.getCommentStream(docId),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        if (snapshot.hasData) {
          recordService.initComment(snapshot.data!.docs);
        }

        var aaa = recordService.comments.map((comment) {
          return Column(
            children: <Widget>[
              Text(
                '${comment.comment}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                '${comment.commentTime}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          );
        }).toList();

        return Column(
          children: aaa,
        );
      },
    );
  }
}
