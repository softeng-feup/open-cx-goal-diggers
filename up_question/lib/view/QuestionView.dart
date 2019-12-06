import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:up_question/controller/database.dart';
import 'package:up_question/model/LocalData.dart';
import 'package:up_question/model/Question.dart';
import 'package:up_question/model/User.dart';
import 'package:up_question/model/Vote.dart';
import 'Widgets/Loading.dart';

class QuestionView extends StatefulWidget {
  final Question question;

  QuestionView({this.question});

  @override
  State<StatefulWidget> createState() {
    return QuestionViewState(question);
  }
}

class QuestionViewState extends State<QuestionView> {
  Question question;

  QuestionViewState(this.question);

  DatabaseService _db = new DatabaseService();

  List<bool> isSelected = [false, false];

  upColor() {
    return isSelected[0] ? Color(0xFF11DE00) : Color(0xFF353535);
  }

  downColor() {
    return isSelected[1] ? Color(0xFFFF0B0B) : Color(0xFF353535);
  }

  @override
  void didUpdateWidget(QuestionView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) this.question = widget.question;
  }

  @override
  Widget build(BuildContext context) {
    List<Like> like = Provider.of<List<Like>>(context);
    List<Dislike> dislike = Provider.of<List<Dislike>>(context);

    if (like == null || dislike == null) return Loading();

    isSelected[0] = like.isNotEmpty;
    isSelected[1] = dislike.isNotEmpty;

    return Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xFF353535), width: 3))),
            child: Column(children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.face),
                      iconSize: 30,
                    ),
                    FutureBuilder<User>(
                      future: _db.getUserByRef(question.userRef),
                      builder:
                          (BuildContext context, AsyncSnapshot<User> snapshot) {
                        if (!snapshot.hasData) {
                          return Loading();
                        } else {
                          final user = snapshot.data;
                          return Text( // TODO: adapt username size to space available (1line)
                              question.anonymous ? "Anonimous" : user.username,
                              style: TextStyle(fontSize: 20));
                        }
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    question.question,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18),
                  )),
              Container(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        key: Key(question.question),
                        icon: Icon(Icons.arrow_upward, color: upColor()),
                        iconSize: 20,
                        onPressed: () {
                          if (isSelected[1]) question.removeDislike(dislike[0]);
                          isSelected[0]
                              ? question.removeLike(like[0])
                              : question.addLike(Like(LocalData.user.userRef));
                        },
                      ),
                      Text(question.votes.toString(),
                          style: TextStyle(fontSize: 18)),
                      IconButton(
                        icon: Icon(Icons.arrow_downward, color: downColor()),
                        iconSize: 20,
                        onPressed: () {
                          if (isSelected[0]) question.removeLike(like[0]);
                          isSelected[1]
                              ? question.removeDislike(dislike[0])
                              : question
                                  .addDislike(Dislike(LocalData.user.userRef));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.insert_comment,
                            color: Color(0xFF353535)),
                        iconSize: 20,
                        onPressed: () {
                        Navigator.pushNamed(context, '/QuestionPage',
                            arguments: question);
                      },
                      ),
                    ],
                  ))
            ]));
  }
}