import 'package:flutter/cupertino.dart';
import 'package:quiver/collection.dart';

import 'User.dart';

class LocalData {
  static User user = new User();
  static bool setLoaded=false;
  static Multimap<String,String> talksLoggs=new Multimap<String, String>();
  static bool speakerLogged=false;
}
