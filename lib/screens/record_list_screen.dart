import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:movement_measure/services/auth_service.dart';
import 'package:movement_measure/services/record_service.dart';
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
    final authService = Provider.of<AuthService>(context);
    final recordService = Provider.of<RecordService>(context);
    recordService.uid = authService.user.uid;

    return StreamBuilder<QuerySnapshot>(
      stream: recordService.getRecordStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        List<Widget> recordCardList = [];
        recordService.init(snapshot.data!.docs);
        recordService.records.forEach((record) {
          final dateTime = recordService.toDateTimeString(record.recordDate);

          RecordCard recordCard = RecordCard(
              id: record.docId,
              dateTime: dateTime,
              time: record.movementTime,
              distance: record.movementDistance);

          recordCardList.add(recordCard);
        });

        return ListView(
          children: recordCardList,
        );
      },
    );
  }
}
