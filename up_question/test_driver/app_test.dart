import 'dart:async';
import 'package:glob/glob.dart';
import'package:gherkin/gherkin.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'steps/user_is_logged_in.dart';


Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r"test_driver/features/logged_in_user.feature")]
    ..stepDefinitions = [InsertedEmail(), InsertedPassword(), TapedLoginButton(), UserLoggedIn()]
    ..reporters = [ProgressReporter(), TestRunSummaryReporter()]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test_driver/app.dart"
    ..exitAfterTestRun = true;
  return GherkinRunner().execute(config);
}