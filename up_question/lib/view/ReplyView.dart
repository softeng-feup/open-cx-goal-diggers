import 'package:flutter/material.dart';
import 'package:up_question/controller/database.dart';
import 'package:up_question/model/Reply.dart';
import 'package:up_question/model/User.dart';
import 'package:up_question/view/Constants.dart';
import 'package:up_question/view/Widgets/Loading.dart';


class ReplyView extends StatefulWidget {
  final Reply reply;

  ReplyView(this.reply);

  @override
  State<StatefulWidget> createState() {
    return ReplyViewState(reply);
  }
}

class ReplyViewState extends State<ReplyView> {
  Reply reply;
  DatabaseService _db = new DatabaseService();

  ReplyViewState(this.reply);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
      decoration: BoxDecoration(
          border:
          Border(bottom: BorderSide(color: Constants.defaultBackgroundColor, width: 3))),
      child: Column(children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.face),
                iconSize: 30,
              ),
              FutureBuilder<User>(
                future: _db.getUserByRef(reply.userReference),
                builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                  if (!snapshot.hasData) {
                    return Loading();
                  } else {
                    final user = snapshot.data;
                    return Text(user.username + " replied", style: Constants.questionReplyUsernameTextStyle);
                  }
                },
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Text(
              reply.reply,
              textAlign: TextAlign.justify,
              style: Constants.questionReplyContentTextStyle,
            ))
      ]),
    );
  }
}
