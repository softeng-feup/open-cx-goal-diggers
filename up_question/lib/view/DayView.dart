import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:up_question/model/Day.dart';
import 'package:up_question/model/day.dart' as prefix0;
import 'package:up_question/view/TalkView.dart';

class DayView extends StatelessWidget {
  final Day day;
  DayView(this.day);
  
  
  String weekdaytoptpt( int weekday){

    switch(weekday){

      case 0 :{
        return "Domingo";
      }

      case 1:{
        return "Segunda-Feira";  
      }
      
      case 2:{
        return "Terça-Feira";
      }

      case 3:{

        return "Quarta-Feira";

      }
      
      case 4:{
        return "Quinta-Feira";
      }
      
      case 5:{

        return "Sexta-Feira";

      }

      case 6:{

        return "Sábado";

      }

    }

    return "Invalid Day";
  }

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
            weekdaytoptpt(2),
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
