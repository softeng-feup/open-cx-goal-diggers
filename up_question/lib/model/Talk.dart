
import 'dart:core';
import 'package:up_question/model/Question.dart';

class Talk extends Comparable {
  String title;
  String speaker;
  DateTime startTime;
  DateTime endTime;
  String location;
  String backgroundImagePath;
  List<Question> questionList = new List();

  Talk({this.title, this.speaker, this.startTime, this.endTime, this.location, this.backgroundImagePath});

  @override
  int compareTo(other) {
    return this.startTime.compareTo(other.startTime);
  }

  Talk.fromMap(Map snapshot, DateTime dayTime) :
    title = snapshot['title'] ?? '',
    speaker = snapshot['speaker'] ?? '',
    location = snapshot['room'] ?? '',
    backgroundImagePath ='assets/images/big_data_back.png' ?? ''
  {
    DateTime date = snapshot['start_time'].toDate();

    startTime = DateTime(dayTime.year, dayTime.month, dayTime.day,
        date.hour, date.minute) ?? '';

    DateTime date2 = snapshot['end_time'].toDate();
    endTime = DateTime(dayTime.year, dayTime.month, dayTime.day,
            date2.hour, date2.minute) ?? '';
  }


}