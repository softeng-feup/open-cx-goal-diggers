import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:up_question/model/Talk.dart';


class Day extends Comparable{
  DocumentReference dayRef;
  DateTime day;
  List<Talk> talks; 
  
  Day({this.day, this.talks});
  Day.fromMap(Map snapshot, DocumentReference reference) : day = snapshot['date'].toDate() ?? '', dayRef = reference ?? '';

  addTalks(List<Talk> talks){
    this.talks = talks;
  }

  @override
  int compareTo(other) {
    return this.day.compareTo(other.day);
  }

  

}