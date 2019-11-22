import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:up_question/controller/database.dart';
import 'package:up_question/model/LocalData.dart';
import 'package:up_question/model/Question.dart';
import 'package:up_question/model/Talk.dart';

class QuestionForm extends StatefulWidget {
  final Talk talk;

  QuestionForm({this.talk});

  @override
  _QuestionFormState createState() {
    return _QuestionFormState(talk: talk);
  }
}

class _QuestionFormState extends State<QuestionForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _question = new Question();
  Talk talk;

  _QuestionFormState({this.talk});

  @override
  Widget build(BuildContext context) {
    DatabaseService _db = new DatabaseService();
    OutlineInputBorder _questionOutlineBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(0.0),
        borderSide: BorderSide(
            color: Color(0xff353535), // TODO: por em const
            width: 1));
    // TODO: implement build
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus)
          currentFocus.unfocus();
      },
      child: new Form(
          key: this._formKey,
          child: new Container(
            alignment: Alignment.topCenter,
            padding: new EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05),
            child: new Container(
              width: 330, // TODO: mudar para em função de ecrã
              height: 540, // TODO: mudar para em função de ecrã
              // height: MediaQuery.of(context).size.height * 0.75,
              //width: MediaQuery.of(context).size.width * 0.85,
              child: new Card(
                  color: Colors.white,
                  elevation: 10.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 30),
                          child: new Text(
                            "Ask your Question!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            enabledBorder: _questionOutlineBorder,
                            focusedBorder: _questionOutlineBorder,
                            errorBorder: _questionOutlineBorder,
                            // TODO: por uma margem vermelha
                            hintText: 'Enter your question here...',
                          ),
                          maxLines: 10,
                          keyboardType: TextInputType.multiline,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a question';
                            }
                          },
                          onSaved: (val) =>
                              setState(() => _question.question = val),
                        ),
                        // TODO: depois remover paddings
                        CheckboxListTile(
                          title: const Text(
                            "Anonimous",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          value: _question.anonimous,
                          // TODO: mudar depois
                          onChanged: (val) {
                            setState(() => _question.anonimous = val);
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Color(0xff353535), // TODO: por em const
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: ButtonTheme(
                            minWidth: double.infinity,
                            height: 44,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              color: Color(0xFF353535),
                              // TODO: por em const
                              textColor: Colors.white,
                              onPressed: () async {
                                final form = _formKey.currentState;
                                if (form.validate()) {
                                  form.save();
                                  _question.talkRef = talk.talkRef;
                                  // TODO: ver isto
                                  _question.userRef = LocalData.user.userRef;

                                  await _db.addQuestion(_question);
                                  // TODO: ver isto
                                  //_showDialog(context);
                                  Navigator.pop(context);
                                }
                              },
                              child: Text(
                                'Share',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ButtonTheme(
                          minWidth: double.infinity,
                          height: 44,
                          child: RaisedButton.icon(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: Color(0xFF2DAAE1),
                            // TODO: por em const
                            textColor: Colors.white,
                            onPressed: () {
                              final form = _formKey.currentState;
                              if (form.validate()) {
                                form.save();
                                //_question.save();
                                _showDialog(context);
                              }
                            },
                            icon: Icon(EvaIcons.twitter),
                            label: Text(
                              'Share with Twitter',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          )),
    );
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting question')));
  }
}
