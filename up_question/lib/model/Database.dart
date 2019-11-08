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
  static DateTime nextDay = DateTime(DateTime.now().month, DateTime.now().day + 1, DateTime.now().minute, DateTime.now().second, DateTime.now().millisecond, DateTime.now().microsecond);
  static List<Talk> talks_2 = [
    Talk(
        title: 'IoT1',
        startTime: nextDay,
        endTime: DateTime(DateTime.now().month, DateTime.now().day + 1, DateTime.now().minute + 60, DateTime.now().second, DateTime.now().millisecond, DateTime.now().microsecond),
        location: 'B 001',
        backgroundImagePath: "assets/images/big_data_back.png"),
    Talk(
        title: 'IoT2',
        startTime: nextDay,
        endTime: DateTime(DateTime.now().month, DateTime.now().day + 1, DateTime.now().minute + 60, DateTime.now().second, DateTime.now().millisecond, DateTime.now().microsecond),
        location: 'B 002',
        backgroundImagePath: 'assets/images/big_data_back.png'),
    Talk(
        title: 'IoT3',
        startTime: nextDay,
        endTime: DateTime(DateTime.now().month, DateTime.now().day + 1, DateTime.now().minute + 60, DateTime.now().second, DateTime.now().millisecond, DateTime.now().microsecond),
        location: 'B 003',
        backgroundImagePath: 'assets/images/big_data_back.png'),
  ];
  static DateTime nextNextDay = DateTime(DateTime.now().month, DateTime.now().day + 2, DateTime.now().minute, DateTime.now().second, DateTime.now().millisecond, DateTime.now().microsecond);
  static List<Talk> talks_3 = [
    Talk(
        title: 'VR1',
        startTime: nextDay,
        endTime: DateTime(DateTime.now().month, DateTime.now().day + 2, DateTime.now().minute + 60, DateTime.now().second, DateTime.now().millisecond, DateTime.now().microsecond),
        location: 'B 001',
        backgroundImagePath: "assets/images/big_data_back.png"),
    Talk(
        title: 'VR2',
        startTime: nextDay,
        endTime: DateTime(DateTime.now().month, DateTime.now().day + 2, DateTime.now().minute + 60, DateTime.now().second, DateTime.now().millisecond, DateTime.now().microsecond),
        location: 'B 002',
        backgroundImagePath: 'assets/images/big_data_back.png'),
    Talk(
        title: 'VR3',
        startTime: nextDay,
        endTime: DateTime(DateTime.now().month, DateTime.now().day + 2, DateTime.now().minute + 60, DateTime.now().second, DateTime.now().millisecond, DateTime.now().microsecond),
        location: 'B 003',
        backgroundImagePath: 'assets/images/big_data_back.png'),
  ];
  //static Day day = Day(day: DateTime.now(), talks: talks_1);
  //static Day day2 = Day(day: nextDay, talks: talks_2);
  //static Day day3 = Day(day: nextNextDay, talks: talks_3);

  //List<Day> schedule = [day, day2, day3];
}
