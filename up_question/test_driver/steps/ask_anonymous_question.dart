import 'package:flutter_driver/flutter_driver.dart';
import'package:gherkin/gherkin.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';


class AndSelectedConference extends And1WithWorld<String, FlutterWorld> {
  AndSelectedConference()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep(String talkTitle) async {
    String conference = 'Data Science';
    await FlutterDriverUtils.tap(world.driver, find.byValueKey(conference));
    final SerializableFinder questionScreen = find.byValueKey('QuestionsScreen');
    await FlutterDriverUtils.isPresent(questionScreen, world.driver);
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"participant has selected the right conference");

}

class EnterQuestion extends AndWithWorld<FlutterWorld> {
  EnterQuestion()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    String input1 = "TestQuestion";
    await FlutterDriverUtils.enterText(world.driver, find.byValueKey('EnterQuestion'), input1);
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"participant has written a question");

}

class TappedAnonymousCheckbox extends When1WithWorld<String, FlutterWorld> {
  TappedAnonymousCheckbox()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep(String talkTitle) async {
    await FlutterDriverUtils.tap(world.driver, find.byValueKey('AnonymousCheckbox'));
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"participant checks the checkbox 'anonymous'");

}

class TappedShareButton extends AndWithWorld<FlutterWorld> {
  TappedShareButton()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    //await FlutterDriverUtils.tap(world.driver, find.byValueKey('Share'));
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"participant has written a question");

}

class AskedAnonymousQuestion extends ThenWithWorld<FlutterWorld> {
  AskedAnonymousQuestion()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 20));
  @override
  Future<void> executeStep() async {
    // TODO: Try to check if qustion was asked anonymously
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"the participant asked a question without revealing his identity");

}