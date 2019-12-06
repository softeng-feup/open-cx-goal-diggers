import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:up_question/model/LocalData.dart';
import 'package:up_question/model/Day.dart';
import 'package:up_question/model/Question.dart';
import 'package:up_question/model/Reply.dart';
import 'package:up_question/model/Talk.dart';
import 'package:up_question/model/User.dart';
import 'package:up_question/model/Vote.dart';

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
        .map((doc) => Question.fromMap(doc.reference, doc.data))
        .toList();

    return tempQuestionList;
  }

  Stream<List<Question>> getQuestionStream(Talk talk)  {
    Stream<QuerySnapshot> stream = dbReference.collection('questions').where('idTalk', isEqualTo: talk.talkRef).snapshots();
    return stream
        .map((snapshot) => snapshot.documents
        .map((doc) => Question.fromMap(doc.reference, doc.data))
        .toList());
    //return dbReference.collection('questions').where('idTalk', isEqualTo: talk.talkRef).snapshots();
  }

  Stream<List<Reply>> getReplyStream(Question question) {
    DocumentReference questionRef = question.questionRef;
    Stream<QuerySnapshot> stream = questionRef.collection('replies').snapshots();
    return stream
        .map((snapshot) => snapshot.documents
        .map((doc) => Reply.fromMap(doc.reference, questionRef, doc.data))
        .toList());
  }

  Stream<List<Like>> getLike(DocumentReference questionRef, DocumentReference userRef){
    Stream <QuerySnapshot> stream = questionRef.collection('likes').where('user', isEqualTo: userRef).snapshots();
    return stream
        .map((snapshot) => snapshot.documents
        .map((doc) => Like.fromMap(doc.reference, doc.data, questionRef))
        .toList());
  }

  Stream<List<Dislike>> getDislike(DocumentReference questionRef, DocumentReference userRef){
    Stream <QuerySnapshot> stream = questionRef.collection('dislikes').where('user', isEqualTo: userRef).snapshots();
    return stream
        .map((snapshot) => snapshot.documents
        .map((doc) => Dislike.fromMap(doc.reference, doc.data, questionRef))
        .toList());
  }

  Future<List<Talk>> retrieveTalkAtDay(Day day)  async {
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
      List<Talk> talks = await retrieveTalkAtDay(day);
      day.addTalks(talks);
    }
    return tempDayList;
  }

  Future addQuestion(Question data) async{
    return await dbReference.collection('questions').add(data.toJson());
  }

  void addReply(DocumentReference questionRef, Reply reply) async {
    await questionRef.collection('replies').add(reply.toJson());
  }

  void addLike(DocumentReference questionRef, Like data) async{
    await questionRef.collection('likes').add(data.toJson());
  }

  void addDislike(DocumentReference questionRef, Dislike data) async{
    await questionRef.collection('dislikes').add(data.toJson());
  }

  void removeLike(DocumentReference questionRef, Like data) async{
    await questionRef.collection('likes').document(data.voteRef.documentID).delete();
  }

  void removeDislike(DocumentReference questionRef, Dislike data) async{
    await questionRef.collection('dislikes').document(data.voteRef.documentID).delete();
  }

  void removeQuestion(Question data) {
    dbReference.collection('questions').document(data.questionRef.documentID).delete();
    data.questionRef.collection('dislikes').getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents){
        ds.reference.delete();
      }
    });
    data.questionRef.collection('likes').getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents){
        ds.reference.delete();
      }
    });
  }
}
