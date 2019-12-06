import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:up_question/controller/database.dart';

import 'Talk.dart';
import 'Vote.dart';

class Question extends Comparable {
  DocumentReference userRef;
  bool anonymous = false;

  DocumentReference questionRef;
  DocumentReference talkRef;
  Talk talk; /// Needed?!
  String question;
  int votes;
  Like like;
  Dislike dislike;
  DateTime postedTime;

  DatabaseService _db = new DatabaseService();

  Question({this.question, this.votes = 0});

  void addLike(Like data) {
    votes++;
    questionRef.updateData({'nVotes': FieldValue.increment(1)});
    _db.addLike(questionRef, data);
  }

  void addDislike(Dislike data) {
    votes--;
    questionRef.updateData({'nVotes': FieldValue.increment(-1)});
    _db.addDislike(questionRef, data);
  }

  void removeLike(Like data) {
    votes--;
    questionRef.updateData({'nVotes': FieldValue.increment(-1)});
    _db.removeLike(questionRef, data);
  }

  void removeDislike(Dislike data) {
    votes++;
    questionRef.updateData({'nVotes': FieldValue.increment(1)});
    _db.removeDislike(questionRef, data);
  }

  @override
  int compareTo(other) {
    if (this.votes == other.votes)
      return this.postedTime.compareTo(other.postedTime);
    return this.votes.compareTo(other.votes);
  }

  Question.fromMap(DocumentReference reference, Map data)
      : questionRef = reference ?? '',
        question = data['question'] ?? '',
        anonymous = data['anonimous'] ?? '',
        talkRef = data['idTalk'] ?? '',
        userRef = data['user'] ?? '',
        votes = data['nVotes'] ?? '' {
    DateTime date = data['postedTime'].toDate();
    postedTime = DateTime(date.year, date.month, date.day,
            date.hour, date.minute, date.second) ??
        '';
  }

  toJson() {
    return {
      "anonimous": anonymous,
      "idTalk": talkRef,
      "nVotes": 0,
      "postedTime": Timestamp.now(),
      "question": question,
      "user": userRef
    };
  }
}
