import 'package:flutter/widgets.dart';
import 'package:up_question/model/Question.dart';

class Talk extends Comparable {
  String title;
  String speaker;
  DateTime startTime;
  DateTime endTime;
  String location;
  Image backgroundImage;
  List<Question> questionList = new List();

  Talk({this.title, this.speaker, this.startTime, this.endTime, this.location, this.backgroundImage});

  @override
  int compareTo(other) {
    return this.startTime.compareTo(other.startTime);
  }

}