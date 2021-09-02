import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movement_measure/widgets/record_card.dart';

class RecordListScreen extends StatelessWidget {
  const RecordListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.black54,
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
    final Stream<QuerySnapshot> _recordsStream = FirebaseFirestore.instance
        .collection('records')
        .orderBy('recordDate', descending: true)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _recordsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        List<Widget> recordCardList = [];
        final records = snapshot.data!.docs;
        records.forEach((record) {
          final recordData = record.data() as Map;
          final distance = recordData['movementDistance'] as double;
          final time = recordData['movementTime'] as String;
          final dateTime = DateFormat('yyyy-MM-dd kk:mm:ss')
              .format(recordData['recordDate'].toDate())
              .toString();

          RecordCard recordCard = RecordCard(
              id: record.id,
              dateTime: dateTime,
              time: time,
              distance: distance);

          recordCardList.add(recordCard);
        });

        return ListView(
          children: recordCardList,
        );
      },
    );
  }
}
