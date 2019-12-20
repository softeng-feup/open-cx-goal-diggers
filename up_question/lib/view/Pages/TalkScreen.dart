import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:up_question/controller/database.dart';
import 'package:up_question/model/LocalData.dart';
import 'package:up_question/model/Question.dart';
import 'package:up_question/model/Talk.dart';
import 'package:up_question/model/Vote.dart';
import 'package:up_question/view/Constants.dart';
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
  String _speakerSignature = "";
  bool showButton = true;
  _TalkScreenState(this.talk);

  String getSpeakerSignature(Talk talk) {
    String ret;
    String _firstLetter;
    String _lastNameFirstLetter;
    int _lastIndexSpace = -1;

    _firstLetter = talk.speaker[0];
    //Find last Space
    _lastIndexSpace = talk.speaker.lastIndexOf(' ');
    //Get the next letter
    _lastIndexSpace++;
    _lastNameFirstLetter = talk.speaker[_lastIndexSpace];

    ret = _firstLetter + _lastNameFirstLetter;
    return ret;
  }

  @override
  void initState() {
    super.initState();
    LocalData.speakerLogged = false;
    _db = new DatabaseService();

    String username = LocalData.user.username;

    if (LocalData.talksLoggs.contains(this.talk.title, username) == true) {
      this._speakerSignature = getSpeakerSignature(talk);
      _isvisibleIcon = false;
      _isSpeakerNameVisible = true;
      LocalData.speakerLogged = true;
    } else {
      //Double Check
      LocalData.speakerLogged = false;
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
      //ADD THE INFO TO THE DATABASE
      LocalData.speakerLogged = true;
      _db.addSpeakerLoggin(LocalData.user.username, this.talk);
      //Get the initials of that talk speaker
      this._speakerSignature = getSpeakerSignature(talk);
      _isSpeakerNameVisible = true;
    } else if (returnVal == null) {
      setState(() {
        _isvisibleIcon = !_isvisibleIcon;
      });
    }
  }

  List<String> _options = ['Top', 'New', 'Old'];
  String _selectedOption = 'Top';

  _toggleShow(bool value) {
    setState(() {
      showButton = value;
    });
  }

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
                            splashColor: Colors.green,
                            child: SizedBox(
                              width: 50.0,
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
                              width: 50,
                              height: 100,
                              child: Center(
                                  child: Text(
                                _speakerSignature,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              ))),
                        ),
                      )),
                ),
              ],
            ),
          ),

          Container(
              color: Constants.defaultBackgroundColor,
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
                                width: 2.0, color: Constants.defaultBackgroundColor)),
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
            child: QuestionList(
              selectedOption: _selectedOption,
              parentAction: _toggleShow,
            ),
          )
        ],
      ),
      floatingActionButton: Visibility(
        visible: showButton,
        child: FloatingActionButton(
          key: Key('AddQuestion'),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return QuestionForm(talk: talk);
                });
          },
          child: Icon(Icons.add),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SpeakerLoginState {
  bool speakerLogged = false;
}

class QuestionList extends StatefulWidget {
  final selectedOption;
  final void Function(bool value) parentAction;

  const QuestionList({this.selectedOption, this.parentAction});

  @override
  State<StatefulWidget> createState() {
    return _QuestionListState(newSelectedOption: selectedOption);
  }
}

class _QuestionListState extends State<QuestionList> {
  String newSelectedOption;
  DatabaseService _db;
  ScrollController controller;

  _QuestionListState({this.newSelectedOption});

  @override
  void initState() {
    super.initState();
    _db = new DatabaseService();

    controller = new ScrollController();
    controller.addListener(() {
      if (controller.position.userScrollDirection == ScrollDirection.reverse) {
        widget.parentAction(false);
      } else {
        if (controller.position.userScrollDirection ==
            ScrollDirection.forward) {
          widget.parentAction(true);
        }
      }
    });
  }

  @override
  void didUpdateWidget(QuestionList oldWidget) {
    if (oldWidget.selectedOption != widget.selectedOption) {
      this.newSelectedOption = widget.selectedOption;
    }
  }

  int compareQuestions(Question question1, Question question2) {
    switch (newSelectedOption) {
      case 'Top':
        return question2.votes - question1.votes;
      case 'New':
        return question2.postedTime.millisecondsSinceEpoch -
            question1.postedTime.millisecondsSinceEpoch;
      case 'Old':
        return question1.postedTime.millisecondsSinceEpoch -
            question2.postedTime.millisecondsSinceEpoch;
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
            onPressed: null,
          ),
        ),
        direction: DismissDirection.endToStart,
        child: QuestionView(question: question, showMoreButton: false,),
      );
    } else {
      return QuestionView(question: question, showMoreButton: false,);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Question> questionsProvided = Provider.of<List<Question>>(context);

    if (questionsProvided != null && questionsProvided.isNotEmpty)
      questionsProvided.sort(compareQuestions);
    return (questionsProvided == null)
        ? Loading()
        : new Expanded(
            child: new ListView.builder(
                controller: controller,
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
                    child: questionWithDismiss(questionsProvided[index]),
                  );
                }),
          );
  }
}
