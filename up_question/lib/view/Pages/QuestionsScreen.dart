import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  //List<Question> questions = new List();

  _QuestionsPageState(this.talk);

  @override
  void initState() {
    super.initState();
    _db = new DatabaseService();
  }

  List<String> _options = ['Top', 'New', 'Old'];
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
                //questions.sort(compareQuestions);
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
          StreamProvider<List<Question>>.value(
              value: _db.getQuestionStream(talk),
              //child: !snapshot.hasData ? Loading() : QuestionList();
            child: QuestionList(selectedOption: _selectedOption,),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return QuestionForm(talk: talk);
              });
        },
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class QuestionList extends StatefulWidget {
  final selectedOption;

  const QuestionList({this.selectedOption});

  @override
  State<StatefulWidget> createState() {
    return _QuestionListState(newSelectedOption: selectedOption);
  }
}

class _QuestionListState extends State<QuestionList> {
  String newSelectedOption;
  //String oldSelectedOption = "";
  //List<Question> questions = new List();

  _QuestionListState({this.newSelectedOption});

  @override
  void didUpdateWidget(QuestionList oldWidget) {
    if (oldWidget.selectedOption != widget.selectedOption) {
      //this.oldSelectedOption = this.newSelectedOption;
      this.newSelectedOption = widget.selectedOption;
      //questions = new List();
      //if(questions.isNotEmpty)
        //questions.sort(compareQuestions);
    }
  }

  int compareQuestions(Question question1, Question question2) {
    switch(newSelectedOption) {
      case 'Top':
        return question2.votes - question1.votes;
      case 'New':
        if (question1.postedTime.isAfter(question2.postedTime))
          return -1;
        if (question1.postedTime.isBefore(question2.postedTime))
          return 1;
        return 0;
      case 'Old':
        if (question1.postedTime.isBefore(question2.postedTime))
          return -1;
        if (question1.postedTime.isAfter(question2.postedTime))
          return 1;
        return 0;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {

    List<Question> questionsProvided = Provider.of<List<Question>>(context);

    /*if ((this.newSelectedOption != this.oldSelectedOption) && (questionsProvided != null)) {
      questionsProvided.sort(compareQuestions);
      this.oldSelectedOption = this.newSelectedOption;
    }*/

    if(questionsProvided != null && questionsProvided.isNotEmpty)
      questionsProvided.sort(compareQuestions);
    return (questionsProvided == null) ?  Loading() :
        new Expanded(
          child: new ListView.builder(
              itemCount: questionsProvided.length,
              itemBuilder: (BuildContext context, int index) {
                return QuestionView(question: questionsProvided[index]);
              }),
        );
  }

}

