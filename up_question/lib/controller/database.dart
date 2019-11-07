import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:up_question/model/Day.dart';
import 'package:up_question/model/Talk.dart';

class DatabaseService {
  //TODO: CONSTRUTOR CHAMAR METODO INIT
  final dbReference = Firestore.instance;

  // TODO: mudar de idDay2 para referencia mesmo
  Future<List<Talk>> retrevieTalkonDay(Day day)  async {
    var talkReference = dbReference.collection('talks').where('idDay2', isEqualTo: day.dayID);
    List<Talk> tempTalkList = List();

    var result = await talkReference.getDocuments();
    tempTalkList = result.documents
        .map((doc) => Talk.fromMap(doc.data, day.day))
        .toList();
    return tempTalkList;
  }

  Future<List<Day>> retrevieSchedule() async {
    var dayReference = dbReference.collection('days');
    List<Day> tempDayList = new List();

    var result = await dayReference.getDocuments();
    //tempDayList = result.documents.map((doc) { print(doc.reference.path); return Day.fromMap(doc.data, doc.reference.path);}).toList();
    tempDayList = result.documents.map((doc) => Day.fromMap(doc.data, doc.documentID)).toList();

    for(var day in tempDayList){
      List<Talk> talks = await retrevieTalkonDay(day);
      day.addTalks(talks);
    }
    return tempDayList;
  }
}
