import 'package:up_question/model/Talk.dart';

class Day extends Comparable{
  String dayID;
  DateTime day; // TODO: ver se isto ou uma Date normal
  List<Talk> talks; // TODO: mudar para estrutura ordenada
  
  Day({this.day, this.talks});
  Day.fromMap(Map snapshot, String ID) : day = snapshot['date'].toDate() ?? '', dayID = ID ?? '';

  addTalks(List<Talk> talks){
    this.talks = talks;
  }

  @override
  int compareTo(other) {
    return this.day.compareTo(other.day);
  }

}