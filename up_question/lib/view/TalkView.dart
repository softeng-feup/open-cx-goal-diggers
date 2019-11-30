import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:up_question/model/LocalData.dart';
import 'package:up_question/model/Talk.dart';
import 'package:up_question/controller/database.dart';
import 'package:up_question/model/LocalData.dart';

class TalkView extends StatelessWidget {
  final Talk localtalk;
  final bool button;

  TalkView(this.localtalk, this.button){
    LocalData.setLoaded=true;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => this.button ? Navigator.pushNamed(context, '/TalkPage', arguments: localtalk) : null,
        child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(localtalk.backgroundImagePath),
                    colorFilter: new ColorFilter.mode(
                        Color.fromRGBO(196, 196, 196, 0.85), BlendMode.dstATop),
                    fit: BoxFit.cover)),
            child: ClipRect(
              child: BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                child: Container(
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.0)),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      //Title
                      Text(
                        localtalk.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                      //Conference Room
                      Text(
                        localtalk.location,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      //Hour and Minutes as INTEGERS
                      //TODO:ESTA A IMPRIMIR NO CABECALHO UM INTEIRO. QUE E WEEKDAY. FAZER UMA FUNCAO PARA CONVERTER O WEEKDAY PARA PT. EXITIRA EMBEBIDA???
                      Text(
                        localtalk.startTime.hour.toString() +
                            ':' +
                            localtalk.startTime.minute.toString() +
                            '-' +
                            localtalk.endTime.hour.toString() +
                            ':' +
                            localtalk.endTime.minute.toString(),
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
