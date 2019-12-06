import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:up_question/model/Question.dart';

import 'User.dart';

class Vote {
  DocumentReference voteRef;
  DocumentReference userRef;
  DocumentReference questionRef;

  Vote(DocumentReference userRef){ this.userRef = userRef; }

  Vote.fromMap(DocumentReference reference, Map data, DocumentReference questionRef) :
        voteRef = reference ?? '',
        questionRef = questionRef ?? '',
        userRef = data['user'] ?? '';
}

class Like extends Vote {
  Like(DocumentReference userRef) : super(userRef);

  Like.fromMap(DocumentReference reference, Map data, DocumentReference questionRef) : super.fromMap(reference, data, questionRef);

  toJson() {
    return {
      "user" : userRef
    };
  }
}

class Dislike extends Vote {
  Dislike(DocumentReference userRef) : super(userRef);

  Dislike.fromMap(DocumentReference reference, Map data, DocumentReference questionRef) : super.fromMap(reference, data, questionRef);

  toJson() {
    return {
      "user" : userRef
    };
  }
}