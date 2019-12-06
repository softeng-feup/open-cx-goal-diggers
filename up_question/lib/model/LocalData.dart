import 'package:flutter/cupertino.dart';

import 'User.dart';

class LocalData {
  static User user = new User();
  static bool setLoaded=false;
  static Set<String> arrayLogged= new Set();
  static bool speakerLogged=false;
}
