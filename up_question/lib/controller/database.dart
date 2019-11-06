import 'package:firebase_database/firebase_database.dart';
import 'package:up_question/model/Day.dart';
import 'package:up_question/model/Talk.dart';
import 'package:intl/intl.dart';

class Talks  {

  Day day;
  //TODO: CONSTRUTOR CHAMAR METODO INIT

  Talks(this.day);


  void retrevieDataonDayX() {

    final String strDayWeek=DateFormat('EEEE').format(day.day);

    final String catstr='talks/'+(strDayWeek.toLowerCase());

    print(catstr);

    final DatabaseReference ref = FirebaseDatabase.instance.reference();

    //os urls para a Database tem o dia sempre em minuscula
    ref.child(catstr).once().then((DataSnapshot snap) {
      var keys = snap.value.keys;

      var data = snap.value;
      day.talks.clear();

      for (var key in keys) {

        DateTime timeAuxStart=DateTime(data[key]['year'],data[key]['month'],data[key]['day'],data[key]['hour'],data[key]['minute']);
        DateTime timeAuxEnd=DateTime(data[key]['year'],data[key]['month'],data[key]['day'],data[key]['hour'],data[key]['minute']);

        //TODO:NULL BACKGROUND PATH
        
        Talk container =  Talk(
          title:data[key]['title'],
          speaker:data[key]['speaker'],
          startTime:timeAuxStart,
          endTime:timeAuxEnd,
          location:data[key]['location'],
          backgroundImagePath: null
        );
      
        day.talks.add(container);

        print('Inserido');
        print(container.title);
        print(container.location);
        print(key);      
      }
    });
  }
}
