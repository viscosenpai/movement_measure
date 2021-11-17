import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:movement_measure/generated/l10n.dart';
import 'package:movement_measure/services/record_service.dart';
import 'package:movement_measure/screens/records/record_list_screen.dart';
import 'package:movement_measure/utilities/constants.dart';
import 'package:movement_measure/widgets/record_detail_card.dart';
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
              return RecordDetailCard(
                  splitDate: splitDate, recordService: recordService, id: id);
            }

            return Loader();
          },
        ),
      ),
    );
  }
}
