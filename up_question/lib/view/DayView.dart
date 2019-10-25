import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:up_question/model/Day.dart';
import 'package:intl/intl.dart';
import 'package:up_question/view/TalkView.dart';

class DayView extends StatelessWidget {
  final Day day;
  DayView(this.day);

  @override
  Widget build(BuildContext context) {
    // TODO: NOT COMPLETED YET
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      //TODO:R.A: LIST VIEW SINCE WE MIGHT NEED TO SCROLL DOWN TALKS IN THE SAME DAY. DISCUSS THIS

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
          constraints: BoxConstraints(
            maxHeight: 80, //TODO:MAX HEIGHT DEVE DEPENDER DO N DE TALKS
            minWidth: 500, //TODO:ESTICAR A TODO O ECRA -> LARGURA ECRA
          ),
          child: Text(
            DateFormat('EEEE').format(day.day),
            style: TextStyle(fontSize: 30,color: Colors.white),
          ),
          padding: EdgeInsets.only(left: 4),
        ),
        //Iterate List of items
        for (var item in day.talks) TalkView(item),

      ],
    );
  }




}
