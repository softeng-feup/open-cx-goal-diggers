import 'package:cloud_firestore/cloud_firestore.dart';

import 'Talk.dart';
import 'User.dart';

class Question extends Comparable {
  DocumentReference questionRef;
  Talk talk;
  String question;
  int votes;
  DateTime postedTime;
  // TODO: ver depois isto
  User user = new User(username: "Default");
  DocumentReference userRef;
  bool anonimous = false;

  Question({this.question, this.votes = 0});

  void upVoted(){
    this.votes++;
  }

  void downVoted(){
    this.votes--;
  }

  @override
  int compareTo(other) {
    if(this.votes == other.votes)
      return this.postedTime.compareTo(other.postedTime);
    return this.votes.compareTo(other.votes);
  }

  Question.fromMap(DocumentReference reference, Map data, DateTime startTime)
      : questionRef = reference ?? '',
        question = data['question'] ?? '',
        anonimous = data['anonimous'] ?? '',
        //talk = data['idTalk'] ?? '',
        userRef = data['user'] ?? '',
        votes = data['nVotes'] ?? ''{
    DateTime date = data['postedTime'].toDate();

    postedTime = DateTime(
        startTime.year, startTime.month, startTime.day, date.hour, date.minute) ?? '';
  }

}
