import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
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
    CollectionReference records =
        FirebaseFirestore.instance.collection('records');

    return FutureBuilder<DocumentSnapshot>(
      future: records.doc(id).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          final dateTime = DateFormat('yyyy-MM-dd kk:mm:ss')
              .format(data['recordDate'].toDate())
              .toString();
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
                      '${data["movementTime"]}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                    ),
                    Text(
                      '${data["movementDistance"]} m',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        return Text("loading");
      },
    );
  }
}
