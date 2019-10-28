import 'package:flutter/material.dart';
import 'package:up_question/model/Question.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        // TODO: relative size
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Color(0xFF353535), width: 3))),
        child: Stack(children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.face),
                  iconSize: 30,
                ),
                Text(_getUserName(question), style: TextStyle(fontSize: 20))
              ],
            ),
          ),
          Container(
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
                    icon: Icon(Icons.arrow_upward, color: Color(0xFF353535)),
                    iconSize: 20,
                    onPressed: null,
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_downward, color: Color(0xFF353535)),
                    iconSize: 20,
                    onPressed: null,
                  ),
                  IconButton(
                    icon: Icon(Icons.insert_comment, color: Color(0xFF353535)),
                    iconSize: 20,
                    onPressed: null,
                  ),
                  IconButton(
                    icon: Icon(Icons.share, color: Color(0xFF353535)),
                    iconSize: 20,
                    onPressed: null,
                  )
                ],
              ))
        ]));
  }

  _getUserName(Question question) {
    if (question.anonimous) return "Anonimous";
    return question.user.username;
  }
}
