import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:up_question/model/Day.dart';
import 'package:up_question/view/DayView.dart';

class ScheduleScreen extends StatelessWidget{
  // TODO: mudar depois para lista
  final Day day;
  ScheduleScreen({this.day});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text( 'Schedule' ),
      ),
      body: DayView(day),
    );
  }
}