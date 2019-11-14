import 'package:flutter_driver/flutter_driver.dart';
import'package:gherkin/gherkin.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';

class UserIsLoggedIn extends GivenWithWorld<FlutterWorld> {
  UserIsLoggedIn()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 30));

  @override
  Future<void> executeStep() async {
    await FlutterDriverUtils.waitForFlutter(world.driver);
    final SerializableFinder scheduleScreen = find.byValueKey('ScheduleScreen');
    await FlutterDriverUtils.isPresent(scheduleScreen, world.driver);
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"The user is logged in");

}

class SelectedConference extends When1WithWorld<String, FlutterWorld> {
  SelectedConference()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep(String talkTitle) async {
    await FlutterDriverUtils.tap(world.driver, find.byValueKey(talkTitle));
    final SerializableFinder questionScreen = find.byValueKey('QuestionsScreen');
    await FlutterDriverUtils.isPresent(questionScreen, world.driver);
    //  TODO: check if it is the QuestionsScreen for the right talk
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"The user selects the conference {string}");

}

class CanAskQuestion extends ThenWithWorld<FlutterWorld> {
  CanAskQuestion()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 20));
  @override
  Future<void> executeStep() async {
    await FlutterDriverUtils.waitForFlutter(world.driver);
    await FlutterDriverUtils.tap(world.driver, find.byValueKey('AddQuestion'));
    final SerializableFinder questionForm = find.byType('Form');
    await FlutterDriverUtils.isPresent(questionForm, world.driver);
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"The user can ask the question in the proper site");

}