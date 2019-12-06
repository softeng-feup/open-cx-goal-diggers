import 'package:flutter_driver/flutter_driver.dart';
import'package:gherkin/gherkin.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';

class ParticipantLogIn extends GivenWithWorld<FlutterWorld> {
  ParticipantLogIn()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 30));

  @override
  Future<void> executeStep() async {
    await FlutterDriverUtils.waitForFlutter(world.driver);
    final SerializableFinder scheduleScreen = find.byValueKey('ScheduleScreen');
    await FlutterDriverUtils.isPresent(scheduleScreen, world.driver);
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"participant has logged in to the application");

}

class ParticipantSelectTalk extends ThenWithWorld<FlutterWorld> {
  ParticipantSelectTalk()
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
  RegExp get pattern => RegExp(r"participant has selected the right conference");

}

class ParticipantSeesQuestion extends GivenWithWorld<FlutterWorld> {
  ParticipantSeesQuestion()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    final SerializableFinder questionScreen = find.byValueKey('QuestionsScreen');
    await FlutterDriverUtils.isPresent(questionScreen, world.driver);
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"participant sees the previously asked questions");

}


class ParticipantVotesQuestion extends ThenWithWorld<FlutterWorld> {
  ParticipantVotesQuestion()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 5));
  @override
  Future<void> executeStep() async {
    await FlutterDriverUtils.tap(world.driver, find.byValueKey('Order'));
    await FlutterDriverUtils.tap(world.driver, find.byValueKey('New'));
    await FlutterDriverUtils.tap(world.driver, find.descendant(of: find.byValueKey('TestQuestion'), matching: find.byValueKey('upvote'), matchRoot: true));
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"participant is able to vote on the previously voted questions");

}