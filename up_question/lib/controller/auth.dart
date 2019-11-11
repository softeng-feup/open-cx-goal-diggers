import 'package:firebase_auth/firebase_auth.dart';
import 'package:up_question/controller/database.dart';

class AuthService{

  final FirebaseAuth _auth=FirebaseAuth.instance;

  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }

  //sign in with email
  Future signIn(String email, String password)async{
    try{
      AuthResult loginResult= await _auth.signInWithEmailAndPassword(email: email,password: password);
      FirebaseUser userReturned=loginResult.user;
      await DatabaseService(uid: userReturned.uid).retrieveUserData();
      return userReturned;
    }
    catch(error){
      print("Login Error");
      print(error.toString());
      return null;
    }
  }

  //register with email & password
  Future<FirebaseUser> register(String email, String username, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email:email,password: password);
      FirebaseUser user = result.user;
      await user.sendEmailVerification();
      await DatabaseService(uid: user.uid).createUserData(username);
      return user;
    }catch(e){
      print("Register Error");
      print(e.toString());
      return null;
    }
  }


  //sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }
    catch(error){
      print("Sign Out Error");
      print(error.toString());
      return null;
    }
  }

  Future resetPassword(String email) async {
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }
    catch(error){
      print("Sign Out Error");
      print(error.toString());
      return null;
    }
  }


}