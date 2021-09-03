import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  late String _docId;
  late String _movementTime;
  late double _movementDistance;
  late Timestamp _recordDate;

  Record(
    this._docId,
    this._movementTime,
    this._movementDistance,
    this._recordDate,
  );

  String get docId => _docId;
  String get movementTime => _movementTime;
  double get movementDistance => _movementDistance;
  Timestamp get recordDate => _recordDate;

  Record.fromMap(map) {
    _docId = map['docId'];
    _movementTime = map['movementTime'];
    _movementDistance = map['movementDistance'];
    _recordDate = map['recordDate'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['movementTime'] = _movementTime;
    map['movementDistance'] = _movementDistance;
    map['recordDate'] = _recordDate;

    return map;
  }
}
