import 'package:cloud_firestore/cloud_firestore.dart';
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

class TalkScreen extends StatefulWidget {
  final Talk talk;

  const TalkScreen(this.talk);

  @override
  _TalkScreenState createState() {
    return _TalkScreenState(talk);
  }
}

class _TalkScreenState extends State<TalkScreen> {
  DatabaseService _db;
  final Talk talk;
  bool _isvisibleIcon;
  bool _isSpeakerNameVisible;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //List<Question> questions = new List();
  _TalkScreenState(this.talk);

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
      LocalData.speakerLogged= true;
      _isSpeakerNameVisible=true;
    } 
    else if (returnVal == null) {
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
                Positioned(child: TalkView(talk)),
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
                            icon: Icon(Icons.work),
                            color: Colors.white,
                            iconSize: 40,
                            onPressed: _isvisibleIcon == false
                                ? null
                                :  _changevisability),
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
                          value: _db.getDislike(
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
