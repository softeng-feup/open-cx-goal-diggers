import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:up_question/controller/RouteGenerator.dart';
import 'package:up_question/controller/auth.dart';

import 'model/Database.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static final Database database = new Database();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/HomePage',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
