import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:movement_measure/generated/l10n.dart';
import 'package:movement_measure/services/record_service.dart';
import 'package:movement_measure/screens/records/record_list_screen.dart';
import 'package:movement_measure/utilities/constants.dart';
import 'package:movement_measure/widgets/message_box.dart';
import 'package:movement_measure/widgets/loader.dart';

class RecordDetailScreen extends StatelessWidget {
  const RecordDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: kDefaultBlur,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
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
          title: Text(S.of(context).detail),
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

    return SafeArea(
      child: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
          future: recordService.getRecordDetail(id),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return MessageBox(message: 'Something went wrong');
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return MessageBox(message: 'Document does not exist');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loader();
            }

            if (snapshot.connectionState == ConnectionState.done) {
              recordService.initDetail(snapshot);
              final dateTime = recordService
                  .toDateTimeString(recordService.record['recordDate']);
              final splitDate = dateTime.split(' ');
              return Container(
                color: Color(0x99000000),
                margin: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      '${splitDate[0]}',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                    ),
                    Text(
                      '${splitDate[1]}',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10.0, right: 16.0, bottom: 10.0, left: 16.0),
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
                              color: Colors.white,
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${recordService.record["movementDistance"]} m',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          _getCommentData(docId: id),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            return Loader();
          },
        ),
      ),
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
          return MessageBox(message: 'Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loader();
        }

        if (snapshot.hasData) {
          recordService.initComment(snapshot.data!.docs);
        }

        var comments = recordService.comments.map((comment) {
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
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ],
            ),
          );
        }).toList();

        return Column(
          children: comments,
        );
      },
    );
  }
}
