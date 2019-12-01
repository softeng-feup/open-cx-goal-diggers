import 'package:flutter_driver/flutter_driver.dart';
import'package:gherkin/gherkin.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';

class InsertedEmail extends GivenWithWorld<FlutterWorld> {
  InsertedEmail()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    FlutterDriverUtils.tap(world.driver, find.byValueKey('AlreadyHasAccount'));
    String input1 = "manuel.monge.coutinho@gmail.com";
    await FlutterDriverUtils.enterText(world.driver, find.byValueKey('Email'), input1);
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"A user inserts an email");

}

class InsertedPassword extends AndWithWorld<FlutterWorld> {
  InsertedPassword()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    String input1 = "123456123";
    await FlutterDriverUtils.enterText(world.driver, find.byValueKey('Password'), input1);
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"A user inserts a password");

}

class TapedLoginButton extends WhenWithWorld<FlutterWorld> {
  TapedLoginButton()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    // TODO: implement executeStep
    //await FlutterDriverUtils.tap(world.driver, find.ancestor(of: find.text('Login'), matching: find.byType('RaisedButton')));
    await FlutterDriverUtils.tap(world.driver, find.byValueKey('LOGIN'));
    return null;
  }

  @override
  // TODO: implement pattern
  RegExp get pattern => RegExp(r"The user hits Login button");

}

class UserLoggedIn extends ThenWithWorld<FlutterWorld> {
  UserLoggedIn()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 20));
  @override
  Future<void> executeStep() async {
    //  TODO: implement verification
    await FlutterDriverUtils.waitForFlutter(world.driver);
    final SerializableFinder scheduleScreen = find.byValueKey('ScheduleScreen');
    await FlutterDriverUtils.isPresent(scheduleScreen, world.driver);
    //expectMatch(LocalData.user.username, matcher)
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"The user is logged in");

}

