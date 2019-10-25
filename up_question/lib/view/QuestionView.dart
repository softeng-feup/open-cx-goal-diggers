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
    return Material(
        child: Container(
            color: Colors.white,
            height: 150,
            // TODO: relative size
            width: 400,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            margin: EdgeInsets.all(5),
            child: Stack(children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.face),
                      iconSize: 30,
                    ),
                    Text("John", style: TextStyle(fontSize: 20))
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
                  padding: EdgeInsets.fromLTRB(150, 0, 0, 0),
                  // TODO: Relative positioning
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_upward),
                        iconSize: 20,
                        onPressed: null,
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 20,
                        onPressed: null,
                      ),
                      IconButton(
                        icon: Icon(Icons.insert_comment),
                        iconSize: 20,
                        onPressed: null,
                      ),
                      IconButton(
                        icon: Icon(Icons.share),
                        iconSize: 20,
                        onPressed: null,
                      )
                    ],
                  ))
            ])));
  }
}
