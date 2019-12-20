import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:up_question/controller/database.dart';
import 'package:up_question/model/Question.dart';
import 'package:up_question/model/Talk.dart';
import 'package:up_question/view/Constants.dart';
import 'package:up_question/view/Widgets/GenericButton.dart';

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
    OutlineInputBorder _questionOutlineBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(0.0),
        borderSide: BorderSide(
            color: Constants.defaultBackgroundColor,
            width: 1));
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
                top: MediaQuery.of(context).size.height * 0.1),
            child: new Container(
              width: 330, // TODO: mudar para em função de ecrã
              height: 470, // TODO: mudar para em função de ecrã
               //height: MediaQuery.of(context).size.height * 0.75,
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
                          key: Key('EnterQuestion'),
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
                            }else{
                              return null;
                            }
                          },
                          onSaved: (val) =>
                              setState(() => _question.question = val),
                        ),
                        // TODO: depois remover paddings
                        CheckboxListTile(
                          key: Key('AnonymousCheckbox'),
                          title: const Text(
                            "Anonymous",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          value: _question.anonymous,
                          onChanged: (val) {
                            setState(() => _question.anonymous = val);
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Constants.defaultBackgroundColor,
                        ),
                        new GenericButton('Share', null, null, _formKey, null,Key('Share'), null,null, _question, talk),
                      ],
                    ),
                  )),
            ),
          )),
    );
  }
}
