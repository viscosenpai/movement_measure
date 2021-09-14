import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:movement_measure/generated/l10n.dart';
import 'package:movement_measure/utilities/constants.dart';
import 'package:movement_measure/services/auth_service.dart';
import 'package:movement_measure/services/record_service.dart';
import 'package:movement_measure/widgets/backdrop_base_sheet.dart';
import 'package:movement_measure/widgets/record_card.dart';

class RecordListScreen extends StatelessWidget {
  const RecordListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropBaseSheet(
      sheetTitle: S.of(context).history,
      bodyComponent: getRecordData(),
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

        if (snapshot.data!.docs.length == 0) {
          return Center(
            child: Text(
              'No Record',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          );
        }

        recordService.init(snapshot.data!.docs);

        return ListView(
          children: recordService.records
              .where((redord) => redord.movementTime != kDefaultMovementTime)
              .map((record) {
            final dateTime = recordService.toDateTimeString(record.recordDate);

            return RecordCard(
                id: record.docId,
                dateTime: dateTime,
                time: record.movementTime,
                distance: record.movementDistance);
          }).toList(),
        );
      },
    );
  }
}
