import 'package:up_question/model/Talk.dart';

class Day extends Comparable{
  DateTime day; // TODO: ver se isto ou uma Date normal
  List<Talk> talks; // TODO: mudar para estrutura ordenada
  
  Day({this.day, this.talks});

  @override
  int compareTo(other) {
    return this.day.compareTo(other.day);
  }

}