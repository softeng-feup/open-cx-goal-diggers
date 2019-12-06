import 'dart:ui';
import 'package:expandable/expandable.dart';
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
import 'package:up_question/view/Widgets/Loading.dart';
import 'package:up_question/view/Widgets/ReplyForm.dart';

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
  ExpandableController _expandableController;

  _QuestionScreenState(this.question);

  @override
  void initState() {
    super.initState();
    _db = new DatabaseService();
    _expandableController = new ExpandableController(initialExpanded: false);
  }

  @override
  Widget build(BuildContext context) {
    if (LocalData.speakerLogged) {
      return Scaffold(
        key: Key('QuestionScreen'),
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
                      value: _db.getDislike(
                          question.questionRef, LocalData.user.userRef)),
                ],
                //child: !snapshot.hasData ? Loading() : QuestionList();
                child: QuestionView(question: question),
              ),
              StreamProvider<List<Reply>>.value(
                  value: _db.getReplyStream(question), child: ReplyList()),
            ],
          ),
          bottomNavigationBar: ExpandableNotifier(
              //initialExpanded: false,
              controller: _expandableController,
              child: Expandable(
                  collapsed: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: InkWell(
                      key: Key('replyOpen'),
                      onTap: () {
                        _expandableController.toggle();
                      },
                      child: Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.add_comment,
                            size: 30,
                            color: Colors.white,
                          ),
                          height: 40,
                          color: Colors.black87),
                    ),
                  ),
                  expanded: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                      height: 120,
                      color: Colors.white70,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          Container(
                            child: InkWell(
                              key: Key('replyClose'),
                              onTap: () {
                                _expandableController.toggle();
                                FocusScope.of(context).unfocus();
                              },
                              child: Container(
                                  padding: EdgeInsets.fromLTRB(0, 5, 15, 0),
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.close,
                                      size: 30, color: Colors.black),
                                  height: 30),
                            ),
                          ),
                          Container(
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: ReplyForm(question: question)),
                          ),
                        ],
                      ),
                      //)
                    ),
                  )))); //ReplyForm(question: question)
    } else {
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
                      value: _db.getDislike(
                          question.questionRef, LocalData.user.userRef)),
                ],
                //child: !snapshot.hasData ? Loading() : QuestionList();
                child: QuestionView(question: question),
              ),
              StreamProvider<List<Reply>>.value(
                  value: _db.getReplyStream(question), child: ReplyList()),
            ],
          ));
    }
  }
}

class ReplyList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ReplyListState();
  }
}

class ReplyListState extends State<ReplyList> {
  @override
  void initState() {
    super.initState();
  }

  int compareReplies(Reply reply1, Reply reply2) {
    if (reply1.postedTime.isBefore(reply2.postedTime)) return -1;
    if (reply1.postedTime.isAfter(reply2.postedTime)) return 1;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    List<Reply> replies = Provider.of<List<Reply>>(context);
    if (replies == null) {
      return Loading();
    } else {
      if (replies.length == 0) {
        return Expanded(
          child: Container(
            alignment: Alignment.center,
            color: Colors.black54,
            child: Text("No replies yet...",
                style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
          ),
        );
      } else {
        replies.sort(compareReplies);
        return /*Container(
        color: Colors.black54,
        //padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: */
            new Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: new ListView.builder(
                itemCount: replies.length,
                itemBuilder: (BuildContext context, int index) {
                  return ReplyView(replies[index]);
                }),
          ),
        );
      }
    }
  }
}
