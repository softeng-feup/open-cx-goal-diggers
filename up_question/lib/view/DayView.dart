import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:up_question/model/Day.dart';
import 'package:intl/intl.dart';
import 'package:up_question/view/TalkView.dart';
import 'package:up_question/controller/database.dart';

class DayView extends StatelessWidget {
  final Day day;
  DayView(this.day);

  
  @override
  Widget build(BuildContext context) {
      DatabaseService aux = DatabaseService();

      aux.retrieveSchedule();
    
      final Day mine=Day(
          day:DateTime.now(),
          talks:[]);
    
    //na database os dias estao em minuscula.

    // TODO: NOT COMPLETED YET
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width:  MediaQuery.of(context).size.width,
          color: Color.fromRGBO(53, 53, 53, 1),
          padding: EdgeInsets.only(left: 4),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              DateFormat('EEEE').format(day.day),
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
        ),
        //Iterate List of items
        for (var item in day.talks) TalkView(item),


      ],
    );
  }




}
