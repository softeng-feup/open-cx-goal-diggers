import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:up_question/main.dart';
import 'package:up_question/view/Pages/HomePage.dart';
import 'package:up_question/view/Pages/QuestionsScreen.dart';
import 'package:up_question/view/Pages/ScheduleScreen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/HomePage': case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/SchedulePage':
        return MaterialPageRoute(builder: (_) => ScheduleScreen(day: MyApp.database.day)); // TODO: fazer agenda e passar agenda
      case '/QuestionsPage':
        return MaterialPageRoute(builder: (_) => QuestionPageView()); // TODO: passar argumentos corretos
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
