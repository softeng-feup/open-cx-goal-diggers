import 'package:flutter/material.dart';

class Constants {
  static Color defaultBackgroundColor = Color(0xFF353535);

  static Color authenticationBackgroundColor = Color(0xAF000000);
  static EdgeInsets authenticationFormPadding = EdgeInsets.only(left: 20.0, right: 20, top: 26, bottom: 8);
  static EdgeInsets authenticationFormFieldPadding = EdgeInsets.only(top: 0, right: 2, left: 2, bottom: 5);
  static TextStyle authenticationHintStyle = TextStyle(color: Color.fromRGBO(255, 255, 255, 0.7));
  static TextStyle authenticationInputTextStyle = TextStyle(fontSize: 20.0, color: Colors.white,);

  static TextStyle questionReplyUsernameTextStyle = TextStyle(fontSize: 20);
  static TextStyle questionReplyContentTextStyle = TextStyle(fontSize: 18);
}