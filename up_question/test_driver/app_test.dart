import 'dart:async';
import 'package:glob/glob.dart';
import'package:gherkin/gherkin.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:test/test.dart';
import 'steps/ask_question.dart';
import 'steps/user_login.dart';


Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r"test_driver/features/**.feature")]
    ..stepDefinitions = [InsertedEmail(), InsertedPassword(), TapedLoginButton(), UserLoggedIn(), UserIsLoggedIn(), SelectedConference(), CanAskQuestion()]
    ..reporters = [ProgressReporter(), TestRunSummaryReporter()]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test_driver/app.dart"
    ..exitAfterTestRun = true;
  return GherkinRunner().execute(config);
}