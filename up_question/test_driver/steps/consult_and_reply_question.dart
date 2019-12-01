import 'package:flutter_driver/flutter_driver.dart';
import'package:gherkin/gherkin.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';

class SubmittedQuestion extends GivenWithWorld<FlutterWorld> {
  SubmittedQuestion()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    //SELECT RIGHT CONFERENCE
    final SerializableFinder scheduleScreen = find.byValueKey('ScheduleScreen');
    await FlutterDriverUtils.isPresent(scheduleScreen, world.driver);
    String conference = 'Data Science';
    await FlutterDriverUtils.tap(world.driver, find.byValueKey(conference));
    //QUESTION SCREEN
    final SerializableFinder questionScreen = find.byValueKey('QuestionsScreen');
    await FlutterDriverUtils.isPresent(questionScreen, world.driver);
    //ADD QUESTION
    await FlutterDriverUtils.tap(world.driver, find.byValueKey('AddQuestion'));
    String input1 = "TestQuestion";
    await FlutterDriverUtils.enterText(world.driver, find.byValueKey('EnterQuestion'), input1);
    await FlutterDriverUtils.tap(world.driver, find.byValueKey('Share'));
    //QUESTION SCREEN
    await FlutterDriverUtils.isPresent(questionScreen, world.driver);
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"participants have submitted their questions");

}

class SpeakerLogIn extends ThenWithWorld<FlutterWorld> {
  SpeakerLogIn()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));
  @override
  Future<void> executeStep() async {
    //MAIN PAGE
    await FlutterDriverUtils.waitForFlutter(world.driver);
    SerializableFinder homepage = find.byValueKey('Homepage');
    FlutterDriverUtils.isPresent(homepage, world.driver);
    //LOGIN
    FlutterDriverUtils.tap(world.driver, find.byValueKey('AlreadyHasAccount'));
    String email = "manuel.monge.coutinho@gmail.com";
    await FlutterDriverUtils.enterText(world.driver, find.byValueKey('Email'), email);
    String password = "123456123";
    await FlutterDriverUtils.enterText(world.driver, find.byValueKey('Password'), password);
    await FlutterDriverUtils.tap(world.driver, find.ancestor(of: find.text('Login'), matching: find.byType('RaisedButton')));
    final SerializableFinder scheduleScreen = find.byValueKey('ScheduleScreen');
    await FlutterDriverUtils.isPresent(scheduleScreen, world.driver);
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"speaker has logged in to the application");

}

class SpeakerSelectTalk extends ThenWithWorld<FlutterWorld> {
  SpeakerSelectTalk()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));
  @override
  Future<void> executeStep() async {
    //SELECT TALK
    String conference = 'Data Science';
    await FlutterDriverUtils.tap(world.driver, find.byValueKey(conference));
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"speaker has selected the right conference");

}

class SpeakerSeesQuestionsAsked extends ThenWithWorld<FlutterWorld> {
  SpeakerSeesQuestionsAsked()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));
  @override
  Future<void> executeStep() async {
    //QUESTION SCREEN
    final SerializableFinder questionScreen = find.byValueKey('QuestionsScreen');
    await FlutterDriverUtils.isPresent(questionScreen, world.driver);
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"speaker sees the questions asked");

}


class AnswerQuestion extends ThenWithWorld<FlutterWorld> {
  AnswerQuestion()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 20));
  @override
  Future<void> executeStep() async {
    // TODO: Select a specific question
    await FlutterDriverUtils.waitForFlutter(world.driver);
    await FlutterDriverUtils.tap(world.driver, find.byValueKey('LogSpeakerIcon'));
    //await FlutterDriverUtils.tap(world.driver, find.byValueKey('ReplyButton'));
    //final SerializableFinder questionScreen = find.byValueKey('Reply');
    //await FlutterDriverUtils.isPresent(questionScreen, world.driver);
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"the speaker can reply the questions asked");

}