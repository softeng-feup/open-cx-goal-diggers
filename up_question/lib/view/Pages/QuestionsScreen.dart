import 'package:flutter/material.dart';
import 'package:up_question/controller/database.dart';
import 'package:up_question/model/Question.dart';
import 'package:up_question/model/Talk.dart';
import 'package:up_question/view/QuestionView.dart';
import 'package:up_question/view/Widgets/Loading.dart';
import 'package:up_question/view/Widgets/QuestionForm.dart';

import '../TalkView.dart';

class QuestionPageView extends StatefulWidget {
  final Talk talk;

  const QuestionPageView(this.talk);
  @override
  _QuestionsPageState createState() {
    return _QuestionsPageState(talk);
  }
}

class _QuestionsPageState extends State<QuestionPageView> {
  DatabaseService _db;
  final Talk talk;

  _QuestionsPageState(this.talk);

  @override
  void initState() {
    super.initState();
    _db = new DatabaseService();
  }

  // TODO: add to database and delete from here
  static List<Question> questions = <Question>[
    new Question(question: "Sample Question0?"),
  ];

  List<String> _options = ['Top', 'Trending', 'New'];
  String _selectedOption = 'Top';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Questions"),
      ),
      body: Column(
        children: <Widget>[
          TalkView(talk),
          DropdownButton(
            value: _selectedOption,
            onChanged: (newValue) {
              setState(() {
                _selectedOption = newValue;
              });
            },
            elevation: 0,
            isDense: true,
            isExpanded: true,
            items: _options.map((option) {
              return DropdownMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(width: 10),
                    new Text(option),
                  ],
                ),
                value: option,
              );
            }).toList(),
          ),
          FutureBuilder<List<Question>>(
            future: _db.retrieveQuestions(talk),
            builder: (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
              if (!snapshot.hasData) {
                return Loading();
              } else {
                final questions = snapshot.data;
                return QuestionsWidget(
                  questions: questions,
                );
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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

class QuestionsWidget extends StatelessWidget {
  final List<Question> questions;

  QuestionsWidget({this.questions});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: new ListView.builder(
          // TODO: problema, so aparece a seguir depois de adicionar a 2ª
          itemCount: questions.length,
          itemBuilder: (BuildContext context, int index) {
            return QuestionView(question: questions[index]);
          }),
    );
  }
}
