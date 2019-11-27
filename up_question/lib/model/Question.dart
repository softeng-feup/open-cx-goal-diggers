import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:up_question/controller/database.dart';
import 'package:up_question/model/Database.dart';

import 'Talk.dart';
import 'User.dart';
import 'Vote.dart';

class Question extends Comparable {
  DocumentReference questionRef;
  DocumentReference talkRef;
  Talk talk;
  String question;
  int votes;
  Like like;
  Dislike dislike;
  DateTime postedTime;

  // TODO: ver depois isto
  DocumentReference userRef;
  bool anonimous = false;

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

  Question.fromMap(DocumentReference reference, Map data, DateTime startTime)
      : questionRef = reference ?? '',
        question = data['question'] ?? '',
        anonimous = data['anonimous'] ?? '',
        talkRef = data['idTalk'] ?? '',
        userRef = data['user'] ?? '',
        votes = data['nVotes'] ?? '' {
    DateTime date = data['postedTime'].toDate();
    postedTime = DateTime(startTime.year, startTime.month, startTime.day,
            date.hour, date.minute) ??
        '';
    ;
  }

  toJson() {
    return {
      "anonimous": anonimous,
      "idTalk": talkRef,
      "nVotes": 0,
      "postedTime": Timestamp.now(),
      "question": question,
      "user": userRef
    };
  }
}
