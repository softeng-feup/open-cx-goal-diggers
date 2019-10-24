import 'Talk.dart';
import 'User.dart';

class Question extends Comparable {
  Talk talk;
  String question;
  int votes;
  DateTime postedTime;
  User user;

  Question({this.question});

  void upVoted(){
    this.votes++;
  }

  void downVoted(){
    this.votes--;
  }

  @override
  int compareTo(other) {
    if(this.votes == other.votes)
      return this.postedTime.compareTo(other.postedTime);
    return this.votes.compareTo(other.votes);
  }

}
