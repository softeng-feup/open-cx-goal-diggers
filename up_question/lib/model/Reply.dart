import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';

class Reply {
  DocumentReference replyReference;
  DocumentReference userReference;
  DocumentReference questionReference;
  String reply;
  DateTime postedTime;

  /*
  * int votes
  * Like like;
  * Dislike dislike;
  * */

  Reply(this.reply);

  Reply.fromMap(DocumentReference reference, Map data)
      : replyReference = reference ?? '',
        userReference = data['idUser'] ?? '',
        questionReference = data['idQuestion'] ?? '',
        reply = data['reply'] ?? '';

  toJson(){
    return {
      "idReply": replyReference,
      "idUser": userReference,
      "idQuestion": questionReference,
      "reply": reply,
      "postedTime": Timestamp.now()
    };
  }
}