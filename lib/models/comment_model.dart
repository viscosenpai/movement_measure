class Comment {
  // late String _docId;
  late String _comment;
  late String _commentTime;
  // late Timestamp _createdAt;

  Comment(
    // this._docId,
    this._comment,
    this._commentTime,
    // this._createdAt,
  );

  // String get docId => _docId;
  String get comment => _comment;
  String get commentTime => _commentTime;
  // Timestamp get createdAt => _createdAt;

  Comment.fromMap(map) {
    // _docId = map['docId'];
    _comment = map['comment'];
    _commentTime = map['commentTime'];
    // _createdAt = map['createdAt'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['comment'] = _comment;
    map['commentTime'] = _commentTime;
    // map['createdAt'] = _createdAt;

    return map;
  }
}
