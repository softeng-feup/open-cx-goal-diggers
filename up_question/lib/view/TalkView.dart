import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:up_question/model/Talk.dart';

class TalkView extends StatelessWidget {
  final Talk localtalk;

  TalkView(this.localtalk);

  @override
  Widget build(BuildContext context) {
    return new Container(
        
        decoration: BoxDecoration(
          image: DecorationImage(
                  image: AssetImage(localtalk.backgroundImagePath),
                  fit: BoxFit.fill
          )
        
        ),
        
        padding: EdgeInsets.only(top:4,left: 4,bottom: 4),
        
        constraints: BoxConstraints(
            maxHeight: 80, //TODO:MAX HEIGHT DEVE DEPENDER DO N DE TALKS
            minWidth: 500, //TODO:ESTICAR A TODO O ECRA -> LARGURA ECRA

        ),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //Title
            Text(localtalk.title,
      
              style: TextStyle(  
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            //Conference Room
            Text(localtalk.location,
                
              style:TextStyle( 
                fontSize: 15,
                color: Colors.white,
              
              ),
            ),

            //Hour and Minutes as INTEGERS

            Text(localtalk.startTime.toString() + '-' + localtalk.endTime.toString(),
              style: TextStyle(
                  
                fontSize: 15,
                color: Colors.white,

                ),  
  
            ),
          ],
        ));
  }
}
