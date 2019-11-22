import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:up_question/controller/database.dart';
import 'package:up_question/model/LocalData.dart';
import 'package:up_question/model/Question.dart';
import 'package:up_question/model/Talk.dart';
import 'package:up_question/model/Vote.dart';
import 'package:up_question/view/QuestionView.dart';
import 'package:up_question/view/Widgets/Loading.dart';
import 'package:up_question/view/Widgets/QuestionForm.dart';
import 'package:up_question/view/Widgets/SpeakerAuthForm.dart';
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
  bool _isvisibleIcon;
  bool _isSpeakerNameVisible;
  bool _speakerLogged = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //List<Question> questions = new List();

  _QuestionsPageState(this.talk);

  @override
  void initState() {
    super.initState();
    _db = new DatabaseService();
    _isvisibleIcon = true;
    _isSpeakerNameVisible = false;
  }

  Future _changevisability() async {
    setState(() {
      _isvisibleIcon = !_isvisibleIcon;
    });

    String returnVal = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SpeakerAuthForm(talk);
        });

    if (returnVal == 'sucess') {
      _speakerLogged = true;
      _isSpeakerNameVisible = true;
    } else if (returnVal == null) {
      setState(() {
        _isvisibleIcon = !_isvisibleIcon;
      });
    }
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
          //Header
          Container(
            child: Stack(
              children: <Widget>[
                Positioned(child: TalkView(talk, false)),
                //Trick to place in the center. It should be half the value of 40
                Positioned(
                    right: 20,
                    top: 20,
                    bottom: 20,
                    child: Visibility(
                      visible: _isvisibleIcon,
                      child: Container(
                          child: Ink(
                        decoration: BoxDecoration(color: Colors.blue),
                        child: IconButton(
                            icon: Icon(EvaIcons.twitter),
                            color: Colors.white,
                            iconSize: 40,
                            onPressed: _isvisibleIcon == false
                                ? null
                                : _changevisability),
                      )),
                    )),

                Positioned(
                  right: 20,
                  top: 25,
                  child: Visibility(
                    visible: _isSpeakerNameVisible,
                    child: Text(
                      "Hello " + talk.speaker,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
              color: Color(0xFF353535),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ButtonTheme(
                      alignedDropdown: true,
                      child: Container(
                        //color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                width: 2.0, color: Color(0XFF353535))),
                        child: DropdownButton(
                          value: _selectedOption,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedOption = newValue;
                              //questions.sort(compareQuestions);
                            });
                          },
                          elevation: 8,
                          isDense: true,
                          style: TextStyle(
                            fontSize: 17,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          items: _options.map((option) {
                            return DropdownMenuItem(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: new Text(option),
                              ),
                              value: option,
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  ])),

          StreamProvider<List<Question>>.value(
            value: _db.getQuestionStream(talk),
            //child: !snapshot.hasData ? Loading() : QuestionList();
            child: QuestionList(
              selectedOption: _selectedOption,
            ),
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

class SpeakerLoginState {
  bool speakerLogged = false;
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
  DatabaseService _db;

  //String oldSelectedOption = "";
  //List<Question> questions = new List();

  _QuestionListState({this.newSelectedOption});

  @override
  void initState() {
    super.initState();
    _db = new DatabaseService();
  }

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
    switch (newSelectedOption) {
      case 'Top':
        return question2.votes - question1.votes;
      case 'New':
        if (question1.postedTime.isAfter(question2.postedTime)) return -1;
        if (question1.postedTime.isBefore(question2.postedTime)) return 1;
        return 0;
      case 'Old':
        if (question1.postedTime.isBefore(question2.postedTime)) return -1;
        if (question1.postedTime.isAfter(question2.postedTime)) return 1;
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

    if (questionsProvided != null && questionsProvided.isNotEmpty)
      questionsProvided.sort(compareQuestions);
    return (questionsProvided == null)
        ? Loading()
        : new Expanded(
            child: new ListView.builder(
                itemCount: questionsProvided.length,
                itemBuilder: (BuildContext context, int index) {
                  return MultiProvider(
                    providers: [
                      StreamProvider<List<Like>>.value(
                          value: _db.getLike(
                              questionsProvided[index].questionRef,
                              LocalData.user.userRef)),
                      StreamProvider<List<Dislike>>.value(
                          value: _db.getDislke(
                              questionsProvided[index].questionRef,
                              LocalData.user.userRef)),
                    ],
                    //child: !snapshot.hasData ? Loading() : QuestionList();
                    child: QuestionView(question: questionsProvided[index]),
                  );
                }),
          );
  }
}
