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

  Reply.fromMap(DocumentReference reference, DocumentReference questionReference, Map data)
      : replyReference = reference ?? '',
        questionReference = questionReference ?? '',
        userReference = data['idUser'] ?? '',
        reply = data['reply'] ?? '';

  toJson(){
    return {
      //"idReply": replyReference,
      "idUser": userReference,
      "reply": reply,
      "postedTime": Timestamp.now()
    };
  }
}