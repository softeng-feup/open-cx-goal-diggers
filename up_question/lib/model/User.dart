class User {
  String username;
  String password;
  String email;
  String uid;
  //User({this.name, this.email});
  User({this.username,this.password,this.email});
  User.loggedUser({this.email, this.uid});

  // TODO: complete
  User.fromData(Map data) : username = data['username'];
}