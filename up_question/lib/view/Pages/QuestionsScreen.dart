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
  String _speakerSignature="";
  

 

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //List<Question> questions = new List();

  _QuestionsPageState(this.talk);

  String getSpeakerSignature(Talk talk){
    
    String ret;
    String _firstLetter;
    String _lastNameFirstLetter;
    int _lastIndexSpace=-1;

    _firstLetter=talk.speaker[0];
    //Find last Space
    _lastIndexSpace=talk.speaker.lastIndexOf(' ');
    //Get the next letter
    _lastIndexSpace++;
    _lastNameFirstLetter=talk.speaker[_lastIndexSpace];
    
    ret=_firstLetter+_lastNameFirstLetter;
    return ret;
  }

  @override
  void initState() {
    super.initState();
    _db = new DatabaseService();
    
    if(LocalData.arrayLogged.contains(talk.title)==false){
      this._speakerSignature=getSpeakerSignature(talk);
      _isvisibleIcon = false;
      _isSpeakerNameVisible = true;

    }else{
      _isvisibleIcon = true;
      _isSpeakerNameVisible = false;
    }

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
      //Get the initials of that talk speaker
      this._speakerSignature=getSpeakerSignature(talk);
      if(LocalData.arrayLogged.contains(talk.title)==true){
        LocalData.arrayLogged.remove(talk.title);
      }else{
        print("PANIC");
      }
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
      key: Key('QuestionsScreen'),
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
                    key: Key('LogSpeakerIcon'),
                    right: 20,
                    top: 20,
                    bottom: 20,
                    child: Visibility(
                      visible: _isvisibleIcon,
                      child: ClipOval(
                          child: Material(
                            color: Colors.red,
                            child: InkWell(
                                // TODO: change icon
                                splashColor: Colors.green,
                                child: SizedBox(
                                  width: 45.0,
                                  height: 100.0,
                                  child: Icon(
                                    Icons.event_note,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                onTap: _isvisibleIcon == false
                                    ? null
                                    : _changevisability),
                          )),
                        )),

                Positioned(
                  right: 20,
                  top: 20,
                  bottom: 20,
                  child: Visibility(
                    visible: _isSpeakerNameVisible,
                    child: ClipOval(
                        child: Material(
                      color: Colors.green,
                      child: SizedBox(
                        width: 45,
                        height: 90,
                        child: Center(
                          child: Text(
                          _speakerSignature,
                          textAlign:TextAlign.center,
                          style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 22,
                                  ),
                        )
                        )
                        ),
                      ),
                    )),
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
                      key: Key('Order'),
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
                              key: Key(option),
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
        key: Key('AddQuestion'),
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

  questionWithDismiss(Question question) {
    if (LocalData.user.userRef == question.userRef) {
      return Dismissible(
        key: Key(question.question),
        onDismissed: (direction) async {
          await _db.removeQuestion(question);
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Question removed")));
        },
        background: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
          color: Colors.red,
          child: IconButton(
            icon: Icon(Icons.delete),
            iconSize: 40,
          ),
        ),
        direction: DismissDirection.endToStart,
        child: QuestionView(question: question),
      );
    } else {
      return QuestionView(question: question);
    }
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
                    child: questionWithDismiss(questionsProvided[index]),
                  );
                }),
          );
  }
}
