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
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        key: Key('ReplyForm'),
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.all(5),
        height: 90,
        child: Form(
          key: this._formKey,
          child: Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(1)),
              Flexible(
                child: TextFormField(
                  key: Key('InsertReply'),
                  decoration: InputDecoration(
                      hintText: 'Insert your reply here...',
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide:
                              new BorderSide(color: Colors.black26, width: 3))),
                  maxLines: 2,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please insert your reply';
                    }else{
                      return null;
                    }
                  },
                  onSaved: (val) => setState(() => reply.reply = val),
                ),
              ),
              ButtonTheme(
                child: IconButton(
                  icon: Icon(Icons.navigation),
                  iconSize: 30,
                  onPressed: () async {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      reply.questionReference = question.questionRef;
                      reply.userReference = LocalData.user.userRef;
                      _db.addReply(question.questionRef, reply);
                      form.reset();
                      FocusScope.of(context).unfocus();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
