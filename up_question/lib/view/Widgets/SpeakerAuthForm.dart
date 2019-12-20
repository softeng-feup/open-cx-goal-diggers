import 'package:flutter/material.dart';
import 'package:up_question/model/Talk.dart';
import 'package:up_question/view/Constants.dart';

class SpeakerAuthForm extends StatefulWidget {
  final Talk talk;

  SpeakerAuthForm(this.talk);

  @override
  _SpeakerAuthPageState createState() {
    return _SpeakerAuthPageState(talk);
  }
}

class _SpeakerAuthPageState extends State<SpeakerAuthForm> {
  String speakerCodeInput;

  final Talk talk;
  final _formKey = GlobalKey<FormState>();

  _SpeakerAuthPageState(this.talk);

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder _questionOutlineBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(0.0),
        borderSide: BorderSide(
            color: Constants.defaultBackgroundColor,
            width: 1));
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: AlertDialog(
        content: Form(
            key: _formKey,
            child: Wrap(
              children: <Widget>[
                TextFormField(
                    key: Key('AutenticationCODE'),
                    decoration: InputDecoration(
                        enabledBorder: _questionOutlineBorder,
                        focusedBorder: _questionOutlineBorder,
                        errorBorder: _questionOutlineBorder,
                        hintText: "Enter the Speaker Code"),
                    autocorrect: false,
                    maxLines: 2,
                    maxLength: 30,
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (val) {
                      setState(() => speakerCodeInput = val);
                    }),
                ButtonTheme(
                    key: Key('LogInAsSpeaker'),
                    minWidth: double.infinity,
                    height: 44,
                    child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        icon: Icon(Icons.send, size: 11),
                        color: Constants.defaultBackgroundColor,
                        textColor: Colors.white,
                        label: Text("Login as Speaker"),
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (form.validate()) {
                            form.save();
                          }
                          if (speakerCodeInput == talk.speakerCode) {
                            Navigator.pop(context, 'sucess');
                          }
                        }))
              ],
            )),
      ),
    );
  }
}
