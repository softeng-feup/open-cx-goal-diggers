import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:up_question/controller/database.dart';
import 'package:up_question/model/LocalData.dart';
import 'package:up_question/model/Question.dart';
import 'package:up_question/model/Reply.dart';
import 'package:up_question/model/Vote.dart';
import 'package:up_question/view/QuestionView.dart';
import 'package:up_question/view/ReplyView.dart';


class QuestionScreen extends StatefulWidget {
  final Question question;

  const QuestionScreen(this.question);

  @override
  State<StatefulWidget> createState() {
    return _QuestionScreenState(question);
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  DatabaseService _db;
  final Question question;

  _QuestionScreenState(this.question);

  @override
  void initState() {
    super.initState();
    _db = new DatabaseService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Replies"),
      ),
      body: Column(
        children: <Widget>[
          MultiProvider(
            providers: [
              StreamProvider<List<Like>>.value(
                  value: _db.getLike(
                      question.questionRef, LocalData.user.userRef)),
              StreamProvider<List<Dislike>>.value(
                  value: _db.getDislke(
                      question.questionRef, LocalData.user.userRef)),
            ],
            //child: !snapshot.hasData ? Loading() : QuestionList();
            child: QuestionView(question: question),
          ),
          ReplyList()
        ],
      ),
    );
  }
}

class ReplyList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ReplyListState();
  }
}

class ReplyListState extends State<ReplyList> {
  List<Reply> replies = new List();

  @override
  Widget build(BuildContext context) {

    Reply dummyReply = new Reply("Boa pergunta! Não sei responder :( ...");
    dummyReply.userReference = LocalData.user.userRef;

    replies.add(dummyReply);

    if (replies.length == 0) {
      return Expanded(
        child: Container(
          alignment: Alignment.center,
          color: Colors.black54,
          child: Text("No replies yet...", style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
        ),
      );
    } else {
      return /*Container(
        color: Colors.black54,
        //padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: */new Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: new ListView.builder(
                itemCount: replies.length,
                itemBuilder: (BuildContext context, int index) {
                  return ReplyView(replies[index]);
                }),
          ),
        );
      /*);
      ;*/
    }
  }
}