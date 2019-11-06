import 'package:firebase_database/firebase_database.dart';
import 'package:up_question/model/Day.dart';
import 'package:up_question/model/Talk.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  //TODO: CONSTRUTOR CHAMAR METODO INIT

  List<Talk> retrevieTalkonDay(String dayKey, DateTime dayTime) {
    List<Talk> tempTalkList = List();

    final DatabaseReference talkBlockRef =
        FirebaseDatabase.instance.reference();

    talkBlockRef.child('talks').once().then((DataSnapshot snapTalk) {
      var keysTalk = snapTalk.value.keys;
      var dataTalk = snapTalk.value;

      for (var key in keysTalk) {
        //Se o dia for o correto entao puxo

        if (dataTalk[key]['idDay'] == dayKey) {
          Talk talkAuxiliar = Talk(
              title: dataTalk[key]['title'],
              speaker: dataTalk[key]['speaker'],
              startTime: DateTime(dayTime.year, dayTime.month, dayTime.day,
                  dataTalk[key]['hour_start'], dataTalk[key]['min_start']),
              endTime: DateTime(dayTime.year, dayTime.month, dayTime.day,
                  dataTalk[key]['hour_finish'], dataTalk[key]['min_finish']),
              location: dataTalk[key]['room'],
              //TODO:ChangeBackgroundImagePath
              backgroundImagePath: 'assets/images/big_data_back.png');

          tempTalkList.add(talkAuxiliar);
          print(tempTalkList.last.endTime.toUtc());
        }
      }
    });
    return tempTalkList;
  }

  List<Day> retrevieDataonDay() {
    List<Day> tempDayList = new List();

    final DatabaseReference ref = FirebaseDatabase.instance.reference();

    ref.child('days').once().then((DataSnapshot snap) {
      //keys inside days block day1....day2...etc
      var keys = snap.value.keys;

      var data = snap.value;

      for (var key in keys) {
        List<Talk> talkListTemp;

        //Limpo array de talks para ter garantia que talks erradas nao sobram em memoria

        DateTime day = DateTime(
            data[key]['year'], data[key]['month'], data[key]['day_month']);

        talkListTemp =  retrevieTalkonDay(key, day);

        //Se houve talks naquele dia, entao adiciono ao array associado ao dia
        if (talkListTemp != null) {
          tempDayList.add(Day(day: day, talks: talkListTemp));
        } else {
          
          tempDayList.add(Day(day: day, talks: null));
        }
      }
    });
    return tempDayList;
  }
}
