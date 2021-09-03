import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movement_measure/models/record_model.dart';

class RecordService extends ChangeNotifier {
  late String uid;
  late List _records;
  late Map<String, dynamic> _record;

  RecordService();

  CollectionReference dataPath =
      FirebaseFirestore.instance.collection('records');

  List get records => _records;
  Map<String, dynamic> get record => _record;

  void init(List<DocumentSnapshot> docs) {
    _records = docs.map((doc) {
      var map = doc.data() as Map;
      map['docId'] = doc.id;
      return Record.fromMap(map);
    }).toList();
  }

  void initDetail(AsyncSnapshot<DocumentSnapshot<Object?>> doc) {
    _record = doc.data!.data() as Map<String, dynamic>;
  }

  Stream<QuerySnapshot<Object?>> getRecordStream() {
    return dataPath
        .where('userId', isEqualTo: uid)
        .orderBy('recordDate', descending: true)
        .snapshots();
  }

  Future<DocumentSnapshot<Object?>> getRecordDetail(String docId) {
    return dataPath.doc(docId).get();
  }

  String toDateTimeString(dynamic recordDate) {
    return DateFormat('yyyy-MM-dd kk:mm:ss')
        .format(recordDate.toDate())
        .toString();
  }
}
