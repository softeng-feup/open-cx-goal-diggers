import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  DocumentReference userRef;
  String uid;
  String username;
  String password;
  String email;


  User({this.username,this.password,this.email});
  User.loggedUser({this.email, this.uid});

  User setUid(String uid) {
    this.uid = uid;

    return this;
  }

  User setUsername(String username) {
    this.username = username;
    return this;
  }

  // TODO: complete
  User.fromData(Map data) : username = data['username'];
}