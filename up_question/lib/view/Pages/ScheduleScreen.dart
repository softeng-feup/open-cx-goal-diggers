import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:up_question/model/Day.dart';
import 'package:up_question/view/DayView.dart';

class ScheduleScreen extends StatelessWidget{
  // TODO: mudar depois para lista
  final List<Day> days;
  ScheduleScreen({this.days});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text( 'Schedule' ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(53, 53, 53, 1),
                /*
                image:DecorationImage(
                  //image: AssetImage(),
                  //fit: BoxFit.fill,

                ),
                */
              ),
              child: Text(
                'USERNAME',
                style: TextStyle(fontSize: 30,color: Colors.white),
              ),
              padding: EdgeInsets.only(left: 4),
            ),
            //Iterate List of items
            for (var day in days) DayView(day),

          ],
        ),
      ),
    );
  }
}