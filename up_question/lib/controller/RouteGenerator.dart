import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:up_question/model/Question.dart';
import 'package:up_question/model/Talk.dart';
import 'package:up_question/view/Pages/HomePage.dart';
import 'package:up_question/view/Pages/QuestionScreen.dart';
import 'package:up_question/view/Pages/TalkScreen.dart';
import 'package:up_question/view/Pages/ScheduleScreen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/HomePage': case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/SchedulePage':
        //return MaterialPageRoute(builder: (_) => ScheduleScreen(days: MyApp.database.schedule)); // TODO: fazer agenda e passar agenda
        return MaterialPageRoute(builder: (_) => ScheduleScreen()); // TODO: fazer agenda e passar agenda
      case '/TalkPage':
        Talk talk = settings.arguments;
        return MaterialPageRoute(builder: (_) => TalkScreen(talk)); // TODO: passar argumentos corretos
      case '/QuestionPage':
        Question question = settings.arguments;
        return MaterialPageRoute(builder: (_) => QuestionScreen(question));
      default:
        return _errorRoute();
    }
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("ERROR", style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  });
}
