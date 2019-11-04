import 'package:firebase_auth/firebase_auth.dart';



class AuthService{

  final FirebaseAuth _auth=FirebaseAuth.instance;

  //sign in with email
  Future signinemail(String email, String password)async{

    try{

      AuthResult loginresult= await _auth.signInWithEmailAndPassword(email: email,password: password);

      FirebaseUser userreturned=loginresult.user;

      return userreturned;

    }

    catch(error){

      print("Erro");
      return null;

    }

  }

  Future registerWithEmailAndPassword(String email,String password) async{

    try{
      AuthResult result=await _auth.createUserWithEmailAndPassword(email:email,password: password);

      FirebaseUser userreturned =result.user;

      return userreturned;

    }catch(e){

      print("Erro a registar");
      return null;


    }

  }

  //register with email & password

  //sign out


}