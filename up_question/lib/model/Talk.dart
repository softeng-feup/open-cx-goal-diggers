import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:up_question/model/Question.dart';

class Talk extends Comparable {
  DocumentReference talkRef;
  String title;
  String speaker;
  DateTime startTime;
  DateTime endTime;
  String location;
  String backgroundImagePath;
  String speakerCode;
  List<Question> questionList = new List();

  Talk(
      {this.title,
      this.speaker,
      this.startTime,
      this.endTime,
      this.location,
      this.backgroundImagePath,
      this.speakerCode});

  @override
  int compareTo(other) {
    return this.startTime.compareTo(other.startTime);
  }

  Talk.fromMap(DocumentReference reference, Map snapshot, DateTime dayTime)
      : talkRef = reference ?? '',
        title = snapshot['title'] ?? '',
        speaker = snapshot['speaker'] ?? '',
        location = snapshot['room'] ?? '',
        speakerCode=snapshot['speaker_code']??'',
        backgroundImagePath = 'assets/images/big_data_back.png' ?? '' {
    DateTime date = snapshot['start_time'].toDate();

    startTime = DateTime(
            dayTime.year, dayTime.month, dayTime.day, date.hour, date.minute) ??
        '';

    DateTime date2 = snapshot['end_time'].toDate();
    endTime = DateTime(dayTime.year, dayTime.month, dayTime.day, date2.hour,
            date2.minute) ??
        '';
  }
}
