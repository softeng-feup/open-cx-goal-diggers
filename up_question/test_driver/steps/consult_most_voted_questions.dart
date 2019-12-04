import 'package:flutter_driver/flutter_driver.dart';
import'package:gherkin/gherkin.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';

class SpeakerLogIn extends GivenWithWorld<FlutterWorld> {
  SpeakerLogIn()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 30));

  @override
  Future<void> executeStep() async {
    await FlutterDriverUtils.waitForFlutter(world.driver);
    final SerializableFinder scheduleScreen = find.byValueKey('ScheduleScreen');
    await FlutterDriverUtils.isPresent(scheduleScreen, world.driver);
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"speaker has logged in to the application");

}

class SpeakerSelectConference extends ThenWithWorld<FlutterWorld> {
  SpeakerSelectConference()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));
  @override
  Future<void> executeStep() async {
    String conference = 'Data Science';
    await FlutterDriverUtils.tap(world.driver, find.byValueKey(conference));
    final SerializableFinder questionScreen = find.byValueKey('QuestionsScreen');
    await FlutterDriverUtils.isPresent(questionScreen, world.driver);
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"speaker has selected the right conference");

}

class UserSubmittedQuestion extends GivenWithWorld<FlutterWorld> {
  UserSubmittedQuestion()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    //await FlutterDriverUtils.tap(world.driver, find.byValueKey('AddQuestion'));
    //String input1 = "TestQuestion";
    //await FlutterDriverUtils.enterText(world.driver, find.byValueKey('EnterQuestion'), input1);
    //await FlutterDriverUtils.tap(world.driver, find.byValueKey('Share'));
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"participants have submitted their questions");

}

class SeeMostVotedQuestion extends GivenWithWorld<FlutterWorld> {
  SeeMostVotedQuestion()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    await FlutterDriverUtils.tap(world.driver, find.byValueKey('Order'));
    await FlutterDriverUtils.tap(world.driver, find.byValueKey('Top'));
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"speaker is able to see the most voted questions made by the participants");

}

class SpeakerSeesQuestionsAskedByParticipants extends ThenWithWorld<FlutterWorld> {
  SpeakerSeesQuestionsAskedByParticipants()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));
  @override
  Future<void> executeStep() async {
    final SerializableFinder questionScreen = find.byValueKey('QuestionsScreen');
    await FlutterDriverUtils.isPresent(questionScreen, world.driver);
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"speaker sees the questions made by the participants");

}

class AnswerMostVotedQuestion extends ThenWithWorld<FlutterWorld> {
  AnswerMostVotedQuestion()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 20));
  @override
  Future<void> executeStep() async {
    await FlutterDriverUtils.waitForFlutter(world.driver);
    await FlutterDriverUtils.tap(world.driver, find.byValueKey('LogSpeakerIcon'));
    String input2 = "aaa";
    await FlutterDriverUtils.enterText(world.driver, find.byValueKey('AutenticationCODE'), input2);
    await FlutterDriverUtils.tap(world.driver, find.byValueKey('LogInAsSpeaker'));
    final SerializableFinder questionScreen = find.byValueKey('QuestionsScreen');
    await FlutterDriverUtils.isPresent(questionScreen, world.driver);
    //await FlutterDriverUtils.tap(world.driver, find.byValueKey('ReplyButton'));
    //final SerializableFinder questionScreen = find.byValueKey('Reply');
    //await FlutterDriverUtils.isPresent(questionScreen, world.driver);
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"speaker is able to answer the most voted questions first");

}
