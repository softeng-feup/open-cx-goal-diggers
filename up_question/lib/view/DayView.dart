import 'package:flutter/widgets.dart';
import 'package:up_question/model/Day.dart';
import 'package:up_question/model/day.dart' as prefix0;
import 'package:up_question/view/TalkView.dart';

class DayView extends StatelessWidget{
  final Day day;
  DayView(this.day);

  @override
  Widget build(BuildContext context) {
    // TODO: NOT COMPLETED YET
    return Column(

      //TODO:R.A: LIST VIEW SINCE WE MIGHT NEED TO SCROLL DOWN TALKS IN THE SAME DAY. DISCUSS THIS
      
      children: <Widget>[
          Container(
            child: Text(day.day.toString()),
          ),
          //Iterate List of items
          for(var item in day.talks) TalkView (item),
          

      ],
    ) ;
  }



 
}