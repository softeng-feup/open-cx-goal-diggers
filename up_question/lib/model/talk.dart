import 'package:up_question/model/question.dart';

class Talk extends Comparable {
  String title;
  String speaker;
  DateTime startTime;
  DateTime endTime;
  String location;
  List<Question> questionList = new List();

  Talk({this.title, this.speaker, this.startTime, this.endTime, this.location});



  @override
  int compareTo(other) {
    return this.startTime.compareTo(other.startTime);
  }

}