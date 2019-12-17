import 'dart:async';
import 'package:glob/glob.dart';
import'package:gherkin/gherkin.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:test/test.dart';
import 'steps/ask_anonymous_question.dart';
import 'steps/ask_question.dart';
import 'steps/user_login.dart';
import 'steps/authentication&activity_connection.dart';
import 'steps/consult_and_reply_question.dart';
import 'steps/consult_most_voted_questions.dart';
import 'steps/vote_asked_questions.dart';


Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r"test_driver/features/user_login.feature")]

    ..stepDefinitions = [
      InsertedEmail(), InsertedPassword(), TapedLoginButton(), UserLoggedIn(), // steps/user_login.dart
      UserIsLoggedIn(), SelectedConference(), CanAskQuestion(), // steps/ask_question.dart
      AndSelectedConference(), EnterQuestion(), TappedAnonymousCheckbox(), TappedShareButton(), AskedAnonymousQuestion(), // steps/ask_anonymous_question.dart
      LaunchedApplication(), Authenticated(), ConnectedToActivity(), // steps/authentication&activity_connection.dart
      SpeakerIsLoggedIn(), SpeakerSelectTalk(), SubmittedQuestion(), SpeakerSeesQuestionsAsked(), AnswerQuestion(), // steps/consult_and_reply.dart
      SpeakerLogIn(), SpeakerSelectConference(), UserSubmittedQuestion(), SeeMostVotedQuestion(), SpeakerSeesQuestionsAskedByParticipants(), AnswerMostVotedQuestion(), // steps/consult_most_voted_questions.dart
      ParticipantLogIn(), ParticipantSelectTalk(), ParticipantSeesQuestion(), ParticipantVotesQuestion() // steps/vote_asked_questions.dart
      ]

    ..reporters = [ProgressReporter(), TestRunSummaryReporter()]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test_driver/app.dart"
    ..exitAfterTestRun = true;
  return GherkinRunner().execute(config);
}