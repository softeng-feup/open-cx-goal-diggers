import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:up_question/controller/database.dart';
import 'package:up_question/model/Database.dart';
import 'package:up_question/model/Day.dart';
import 'package:up_question/view/DayView.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() {
    return _ScheduleScreenState();
  }
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DatabaseService _db;
  @override
  void initState() {
    super.initState();
    _db  = new DatabaseService();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

/*class ScheduleScreen extends StatelessWidget{
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
}*/
