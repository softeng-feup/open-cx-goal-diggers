import 'package:flutter/material.dart';
import 'package:up_question/controller/database.dart';
import 'package:up_question/model/LocalData.dart';
import 'package:up_question/model/Question.dart';
import 'package:up_question/model/Reply.dart';

class ReplyForm extends StatefulWidget {
  final Question question;

  const ReplyForm({this.question});

  @override
  State<StatefulWidget> createState() {
    return ReplyFormState(question);
  }
}

class ReplyFormState extends State<ReplyForm> {
  final Question question;
  Reply reply = new Reply();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  //DatabaseService _db;

  ReplyFormState(this.question);

  @override
  void initState() {
    super.initState();
    //_db = new DatabaseService();
  }

  @override
  Widget build(BuildContext context) {
    DatabaseService _db = new DatabaseService();
    return Container(
      child: Form(
          key: this._formKey,
          child: Card(
            child: Column(
              children: <Widget>[
                TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Insert your reply here...',
                    ),
                    maxLines: 10,
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please insert your reply';
                      }
                    },
                    onSaved: (val) => setState(() => reply.reply = val),
                  ),

                ButtonTheme(
                  minWidth: double.infinity,
                  height: 44,
                  child: RaisedButton(
                    textColor: Colors.white,
                    onPressed: () async {
                      final form = _formKey.currentState;
                      if (form.validate()) {
                        form.save();
                        reply.questionReference = question.questionRef;
                        reply.userReference = LocalData.user.userRef;
                        _db.addReply(question.questionRef, reply);
                      }
                    },
                    child: Text(
                      'Send',
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
    );
  }
}
