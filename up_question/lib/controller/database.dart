import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:up_question/model/LocalData.dart';
import 'package:up_question/model/Day.dart';
import 'package:up_question/model/Question.dart';
import 'package:up_question/model/Talk.dart';
import 'package:up_question/model/User.dart';

class DatabaseService {
  //TODO: CONSTRUTOR CHAMAR METODO INIT
  final dbReference = Firestore.instance;

  final String uid;

  DatabaseService({this.uid});


  Future<User> getUserByRef(DocumentReference userRef) async{
    var result = await userRef.get();
    User tempUser = User.fromData(result.data);
    return tempUser;
  }

  Future createUserData(String username) async {
    return await dbReference.collection('users').document(uid).setData({'username': username});
  }

  Future retrieveUserData() async {
    User user = LocalData.user;
    user.userRef = dbReference.collection('users').document(uid);
    DocumentSnapshot documentSnapshot = await user.userRef.get();

    if (documentSnapshot.exists) {
      user.username = documentSnapshot.data['username'];
      user.uid = uid;
    }

  }

  Future<List<Question>> retrieveQuestions(Talk talk) async {
    var questionReference = dbReference.collection('questions').where('idTalk', isEqualTo: talk.talkRef);
    List<Question> tempQuestionList = List();

    var result = await questionReference.getDocuments();
    tempQuestionList = result.documents
        .map((doc) => Question.fromMap(doc.reference, doc.data, talk.startTime))
        .toList();

    return tempQuestionList;
  }

  Future<List<Talk>> retrieveTalkonDay(Day day)  async {
    var talkReference = dbReference.collection('talks').where('idDay', isEqualTo: day.dayRef);
    List<Talk> tempTalkList = List();

    var result = await talkReference.getDocuments();
    tempTalkList = result.documents
        .map((doc) => Talk.fromMap(doc.reference, doc.data, day.day))
        .toList();
    return tempTalkList;
  }

  Future<List<Day>> retrieveSchedule() async {
    var dayReference = dbReference.collection('days');
    List<Day> tempDayList = new List();

    var result = await dayReference.getDocuments();
    tempDayList = result.documents.map((doc) => Day.fromMap(doc.data, doc.reference)).toList();

    for(var day in tempDayList){
      List<Talk> talks = await retrieveTalkonDay(day);
      day.addTalks(talks);
    }
    return tempDayList;
  }

  Future addQuestion(Question data) async{
    var result = await dbReference.collection('questions').add(data.toJson()) ;

    return ;

  }
}
