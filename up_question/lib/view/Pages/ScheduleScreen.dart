import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:up_question/model/Day.dart';
import 'package:up_question/view/DayView.dart';

class ScheduleScreen extends StatelessWidget {
  // TODO: mudar depois para lista
  final List<Day> days;

  ScheduleScreen({this.days});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Schedule'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Color(0xFF353535), width: 3.0)),
              image: DecorationImage(
                  image: AssetImage("assets/images/user_bg.png"),
                  colorFilter: new ColorFilter.mode(
                      Colors.white.withOpacity(0.85), BlendMode.dstATop),
                  fit: BoxFit.fill),
            ),
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 1, sigmaY: 1),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                child: Row(
                  children: <Widget>[
                    Container(
                        width: 52,
                        height: 52,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    "assets/images/profile_pic.png")))),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        'Default',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //Iterate List of items
          Expanded(
            child: new ListView.builder(
                itemCount: this.days.length,
                itemBuilder: (BuildContext context, int index) {
                  return DayView(this.days[index]);
                }),
          )
        ],
      ),
    );
  }
}
