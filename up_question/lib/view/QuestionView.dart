import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:up_question/controller/database.dart';
import 'package:up_question/model/LocalData.dart';
import 'package:up_question/model/Question.dart';
import 'package:up_question/model/User.dart';
import 'package:up_question/model/Vote.dart';
import 'package:up_question/view/Constants.dart';
import 'Widgets/Loading.dart';

class QuestionView extends StatefulWidget {
  final Question question;
  final bool showMoreButton;

  QuestionView({this.question, this.showMoreButton});

  @override
  State<StatefulWidget> createState() {
    return QuestionViewState(question, showMoreButton);
  }
}

class QuestionViewState extends State<QuestionView> {
  Question question;
  bool type;

  QuestionViewState(this.question, this.type);

  DatabaseService _db = new DatabaseService();

  List<bool> isSelected = [false, false];

  upColor() {
    return isSelected[0] ? Color(0xFF11DE00) : Constants.defaultBackgroundColor;
  }

  downColor() {
    return isSelected[1] ? Color(0xFFFF0B0B) : Constants.defaultBackgroundColor;
  }

  @override
  void didUpdateWidget(QuestionView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) this.question = widget.question;
  }

  @override
  Widget build(BuildContext context) {
    List<Like> like = Provider.of<List<Like>>(context);
    List<Dislike> dislike = Provider.of<List<Dislike>>(context);

    if (like == null || dislike == null) return Loading();

    isSelected[0] = like.isNotEmpty;
    isSelected[1] = dislike.isNotEmpty;

    return Container(
        key: Key(question.question),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                  onPressed: null,
                ),
                FutureBuilder<User>(
                  future: _db.getUserByRef(question.userRef),
                  builder:
                      (BuildContext context, AsyncSnapshot<User> snapshot) {
                    if (!snapshot.hasData) {
                      return Loading();
                    } else {
                      final user = snapshot.data;
                      return Text(
                          question.anonymous ? "Anonimous" : user.username,
                          style: Constants.questionReplyUsernameTextStyle);
                    }
                  },
                ),
              ],
            ),
          ),
          QuestionText(question.question, type),
          Container(
              key: Key('Buttons'),
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    key: Key('upvote'),
                    icon: Icon(Icons.arrow_upward, color: upColor()),
                    iconSize: 20,
                    onPressed: () {
                      if (isSelected[1]) question.removeDislike(dislike[0]);
                      isSelected[0]
                          ? question.removeLike(like[0])
                          : question.addLike(Like(LocalData.user.userRef));
                    },
                  ),
                  Text(question.votes.toString(),
                      style: TextStyle(fontSize: 18)),
                  IconButton(
                    key: Key('downvote'),
                    icon: Icon(Icons.arrow_downward, color: downColor()),
                    iconSize: 20,
                    onPressed: () {
                      if (isSelected[0]) question.removeLike(like[0]);
                      isSelected[1]
                          ? question.removeDislike(dislike[0])
                          : question
                              .addDislike(Dislike(LocalData.user.userRef));
                    },
                  ),
                  IconButton(
                    key: Key('reply'),
                    icon: Icon(Icons.insert_comment, color: Constants.defaultBackgroundColor),
                    iconSize: 20,
                    onPressed: () {
                      Navigator.pushNamed(context, '/QuestionPage',
                          arguments: question);
                    },
                  ),
                ],
              ))
        ]));
  }
}

class QuestionText extends StatefulWidget {
  String questionText;
  bool type;

  QuestionText(this.questionText, this.type);

  @override
  State<StatefulWidget> createState() {
    if (type)
      return QuestionTextStateShowMore(questionText);
    else
      return QuestionTextState(questionText);
  }
}

class QuestionTextState extends State<QuestionText> {
  String question;

  QuestionTextState(this.question);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        alignment: Alignment.centerLeft,
        child: Text(
          question,
          textAlign: TextAlign.justify,
          style: Constants.questionReplyContentTextStyle,
        ));
  }
}

class QuestionTextStateShowMore extends State<QuestionText> {
  String question;

  String firstHalf;
  String secondHalf;

  bool flag = true;

  QuestionTextStateShowMore(this.question);

  @override
  void initState() {
    super.initState();

    if (question.length > 88) {
      firstHalf = question.substring(0, 85);
      secondHalf = question.substring(85, question.length);
    } else {
      firstHalf = question;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Container(padding: EdgeInsets.all(5),
        alignment: Alignment.centerLeft,
        child: secondHalf.isEmpty
            ? new Text(firstHalf,
              style: Constants.questionReplyContentTextStyle,
              textAlign: TextAlign.justify)
            : new Column(
                children: <Widget>[
                  Container(padding: EdgeInsets.all(5),
                      alignment: Alignment.centerLeft,
                      child: new Text(
                    flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                    style: Constants.questionReplyContentTextStyle,
                    textAlign: TextAlign.justify,
                  )),
                  new InkWell(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          flag ? "show more" : "show less",
                          style: new TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        flag = !flag;
                      });
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
