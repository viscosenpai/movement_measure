import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movement_measure/utilities/constants.dart';
import 'package:movement_measure/models/record_model.dart';
import 'package:movement_measure/models/comment_model.dart';

class RecordService extends ChangeNotifier {
  late String uid;
  late String docId;
  late List _records;
  late Map<String, dynamic> _record;
  late List _comments;
  late Map<String, dynamic> _comment;

  RecordService();

  CollectionReference dataPath =
      FirebaseFirestore.instance.collection('records');

  List get records => _records;
  Map<String, dynamic> get record => _record;
  List get comments => _comments;
  Map<String, dynamic> get comment => _comment;

  void init(List<DocumentSnapshot> docs) {
    _records = docs.map((doc) {
      var map = doc.data() as Map;
      map['docId'] = doc.id;
      return Record.fromMap(map);
    }).toList();
  }

  void initComment(List<DocumentSnapshot> docs) {
    _comments = docs.map((doc) {
      var map = doc.data() as Map;
      return Comment.fromMap(map);
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

  Stream<QuerySnapshot<Object?>> getCommentStream(String docId) {
    return dataPath
        .doc(docId)
        .collection('comments')
        .orderBy('commentTime')
        .snapshots();
  }

  void setDocument(String userId, double distance, DateTime time) {
    var now = new DateTime.now();
    Timestamp updatedAtTimestamp = Timestamp.fromDate(now);
    _record['userId'] = userId;
    _record['movementDistance'] = distance;
    _record['movementTime'] = DateFormat.Hms().format(time);
    _record['recordDate'] = updatedAtTimestamp;
  }

  Future<void> initDocument(String userId) {
    return dataPath.add({
      'userId': userId,
      'movementDistance': 0.0,
      'movementTime': kDefaultMovementTime,
      'recordDate': Timestamp.now(),
    }).then((value) async {
      var snapshot = await value.get();
      docId = snapshot.id;
      var doc = snapshot.data() as Map<String, dynamic>;
      doc['docId'] = docId;
      _record = doc;
      notifyListeners();
    }).catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> saveDocument() {
    print('update record: ${_record}');
    return dataPath
        .doc(_record['docId'])
        .update(_record)
        .then((value) => print('document update'))
        .catchError((error) => print("Failed to update record: $error"));
  }

  Future<void> deleteDocument() {
    return dataPath
        .doc(_record['docId'])
        .delete()
        .then((value) => print('document delete'))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addComment(String docId, Map<String, dynamic> map) {
    return dataPath
        .doc(docId)
        .collection('comments')
        .add(map)
        .then((value) async {})
        .catchError((error) => print("Failed to add user: $error"));
  }

  String toDateTimeString(dynamic recordDate) {
    return DateFormat('yyyy-MM-dd kk:mm:ss')
        .format(recordDate.toDate())
        .toString();
  }
}
