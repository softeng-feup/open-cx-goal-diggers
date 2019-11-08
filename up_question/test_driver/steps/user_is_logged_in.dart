import 'package:flutter_driver/flutter_driver.dart';
import'package:gherkin/gherkin.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';


class InsertedEmail extends GivenWithWorld<FlutterWorld> {
  InsertedEmail()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 60));

  @override
  Future<void> executeStep() async {
    // TODO: implement executeStep
    FlutterDriverUtils.tap(world.driver, find.ancestor(of: find.text('Already have an account?'), matching: find.byType('ButtonTheme')));
    String input1 = "test@test.com";
    //await FlutterDriverUtils.tap(world.driver, find.byValueKey('inputKeyString'));
    await FlutterDriverUtils.enterText(world.driver, find.byValueKey('Email'), input1);
    return null;
  }

  @override
  // TODO: implement pattern
  RegExp get pattern => RegExp(r"A user inserts an email");

}

class InsertedPassword extends AndWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    // TODO: implement executeStep
    String input1 = "password";
    //await FlutterDriverUtils.tap(world.driver, find.byValueKey('inputKeyString'));
    await FlutterDriverUtils.enterText(world.driver, find.byValueKey('Password'), input1);
    return null;
  }

  @override
  // TODO: implement pattern
  RegExp get pattern => RegExp(r"A user inserts a password");

}

class TapedLoginButton extends WhenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() {
    // TODO: implement executeStep
    return null;
  }

  @override
  // TODO: implement pattern
  RegExp get pattern => RegExp(r"The user hits Login button");

}

class UserLoggedIn extends ThenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() {
    // TODO: implement executeStep
    return null;
  }

  @override
  // TODO: implement pattern
  RegExp get pattern => RegExp(r"The user is logged in");

}

