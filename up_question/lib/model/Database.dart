import 'Day.dart';
import 'Talk.dart';
import 'User.dart';

class Database {
  List<User> users = List();
  static List<Talk> talks_1 = [
    Talk(
        title: 'Big Data1',
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        location: 'B 001',
        backgroundImagePath: "assets/images/big_data_back.png"),
    Talk(
        title: 'Big Data2',
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        location: 'B 002',
        backgroundImagePath: 'assets/images/big_data_back.png'),
    Talk(
        title: 'Big Data3',
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        location: 'B 003',
        backgroundImagePath: 'assets/images/big_data_back.png'),
  ];
  Day day = Day(day: DateTime.now(), talks: talks_1);
}
