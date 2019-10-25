import 'package:flutter/material.dart';
import 'package:up_question/model/Question.dart';
import 'package:up_question/model/Talk.dart';
import 'package:up_question/view/QuestionView.dart';
import 'package:up_question/view/Widgets/QuestionForm.dart';

import '../TalkView.dart';

class QuestionPageView extends StatefulWidget {


  @override
  _QuestionsPageState createState() {
    return _QuestionsPageState();
  }
}

class _QuestionsPageState extends State<QuestionPageView>{
  // TODO:
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
      backgroundImagePath: "assets/images/big_data_back.png");

  static List<Question> questions = <Question>[
    new Question(question: "Sample Question0?"),
    new Question(question: "Sample Question1?"),
    new Question(question: "Sample Question2?"),
    new Question(question: "Sample Question3?"),
    new Question(question: "Sample Question4?"),
    new Question(question: "Sample Question5?"),
    new Question(question: "Sample Question6?")
  ];

  int value = questions.length;

  _addItem() {
    setState(() {
      value++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Questions"),
      ),
      body: new Container(
        child: Material(
          child: Stack(
            children: <Widget>[
              TalkView(T),
              ListView.builder(
                  itemCount: this.value,
                  itemBuilder: (BuildContext context, int index) {
                    return QuestionView(question: questions[index]);
                  })
            ],
          ),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(color: Colors.grey),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addItem();
          showDialog(
              context: context,
              builder: (context) {
                return QuestionForm(questionList: questions);
              });
        },
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

