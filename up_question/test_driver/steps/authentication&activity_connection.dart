import 'package:flutter_driver/flutter_driver.dart';
import'package:gherkin/gherkin.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';

class LaunchedApplication extends GivenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() {
    SerializableFinder homepage = find.byValueKey('Homepage');
    FlutterDriverUtils.isPresent(homepage, world.driver);
    return null;
  }

  @override
  // TODO: implement pattern
  RegExp get pattern => RegExp(r"both participant or user have launched the application");
  
}

class Authenticated extends WhenWithWorld<FlutterWorld> {
  Authenticated()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
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
  // TODO: implement pattern
  RegExp get pattern => RegExp(r"both participant or user have logged in");

}

class ConnectedToActivity extends ThenWithWorld<FlutterWorld>{

  @override
  Future<void> executeStep() async {
    await FlutterDriverUtils.tap(world.driver, find.byValueKey('Data Science'));
    final SerializableFinder questionScreen = find.byValueKey('QuestionsScreen');
    await FlutterDriverUtils.isPresent(questionScreen, world.driver);
    return null;
  }

  @override
  // TODO: implement pattern
  RegExp get pattern => RegExp(r"both participant or user are able to connect their profile to the activity they are intending");

}