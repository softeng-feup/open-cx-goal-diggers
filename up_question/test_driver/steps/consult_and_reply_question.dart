import 'package:flutter_driver/flutter_driver.dart';
import'package:gherkin/gherkin.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';

class SubmittedQuestions extends GivenWithWorld<FlutterWorld> {
  SubmittedQuestions()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    // TODO: try to retreive info from database
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"participants have submitted their questions");

}

class AnswerQuestion extends ThenWithWorld<FlutterWorld> {
  AnswerQuestion()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 20));
  @override
  Future<void> executeStep() async {
    // TODO: Select a specific question
    //await FlutterDriverUtils.tap(world.driver, find.byValueKey('ReplyButton'));
    //final SerializableFinder questionScreen = find.byValueKey('Reply');
    //await FlutterDriverUtils.isPresent(questionScreen, world.driver);
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"the speaker can reply the questions asked");

}