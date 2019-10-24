import 'package:flutter/material.dart';
import 'package:up_question/model/Question.dart';
import 'package:up_question/model/Talk.dart';
import 'package:up_question/model/User.dart';
import 'package:up_question/view/TalkView.dart';

class QuestionPageView extends StatelessWidget {
  /*
  * Testing
  * -----------
  * */
  Talk T = new Talk(
      title: "Internet Security",
      speaker: "John",
      startTime: new DateTime.now(),
      endTime: new DateTime.now(),
      location: "FEUP",
      backgroundImagePath: "assets\images\BIG_DATA_BACKGROUND.png");

  final List<Question> questions = <Question>[
    new Question(question: "Sample Question0?"),
    new Question(question: "Sample Question1?"),
    new Question(question: "Sample Question2?"),
    new Question(question: "Sample Question3?"),
    new Question(question: "Sample Question4?"),
    new Question(question: "Sample Question5?"),
    new Question(question: "Sample Question6?")
  ];

  /*
  * -----------
  * */
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (BuildContext context, int index) {
            return QuestionView(question: questions[index]);
          }),
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      decoration: BoxDecoration(color: Colors.grey),
    );
  }
}

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
            height: 150, // TODO: relative size
            width: 400,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            margin: EdgeInsets.all(5),
            child: Stack(children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Row(children: <Widget>[IconButton(icon: Icon(Icons.face), iconSize: 30,), Text("John", style: TextStyle(fontSize: 20))],),
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
                        iconSize: 18,
                        onPressed: null,
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 18,
                        onPressed: null,
                      ),
                      IconButton(
                        icon: Icon(Icons.insert_comment),
                        iconSize: 18,
                        onPressed: null,
                      ),
                      IconButton(
                        icon: Icon(Icons.share),
                        iconSize: 18,
                        onPressed: null,
                      )
                    ],
                  ))
            ])));
  }
}
