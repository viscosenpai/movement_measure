import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ModalRecordListSheet extends StatelessWidget {
  const ModalRecordListSheet({
    Key? key,
    required this.mainContext,
  }) : super(key: key);

  final BuildContext mainContext;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(mainContext).padding.top,
        ),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 30.0,
              icon: Icon(Icons.close),
            ),
            title: Text('History'),
          ),
          body: getRecordData(),
        ),
      ),
    );
  }
}

class getRecordData extends StatefulWidget {
  const getRecordData({Key? key}) : super(key: key);

  @override
  _getRecordDataState createState() => _getRecordDataState();
}

class _getRecordDataState extends State<getRecordData> {
  @override
  Widget build(BuildContext context) {
    // CollectionReference records =
    //     FirebaseFirestore.instance.collection('records');
    final Stream<QuerySnapshot> _recordsStream =
        FirebaseFirestore.instance.collection('records').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _recordsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        List<ListTile> recordList = [];
        final records = snapshot.data!.docs.reversed;
        records.forEach((record) {
          final recordData = record.data() as Map;
          final distance = recordData['movementDistance'];
          final time = recordData['movementTime'];
          final date = recordData['recordDate'];
          print(distance);
          print(time);
          print(DateFormat('yyyy-MM-dd kk:mm:ss')
              .format(date.toDate())
              .toString());
          final recordText = ListTile(
            title: Text(
              '$distance m',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              time,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
          recordList.add(recordText);
        });

        return ListView(
          children: recordList,
        );
      },
    );
  }
}
