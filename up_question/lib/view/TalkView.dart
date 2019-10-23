import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class TalkView extends StatelessWidget {
  final String talkTitle, room,assetBackgroundPath;
  final int hour, minutes;

  TalkView({this.talkTitle, this.hour, this.minutes, this.room,this.assetBackgroundPath});

  @override
  Widget build(BuildContext context) {
    return new Container(
        
        decoration: BoxDecoration(
          image: DecorationImage(
                  image: AssetImage(assetBackgroundPath),
                  fit: BoxFit.fill
          )
        
        ),
        
        padding: EdgeInsets.only(top:4,left: 4,bottom: 4),
        
        constraints: BoxConstraints(
            maxHeight: 80,
            minWidth: 500,

        ),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //Title
            Text(talkTitle,
      
              style: TextStyle(  
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            //Conference Room
            Text(room,
                
              style:TextStyle( 
                fontSize: 15,
                color: Colors.white,
              
              ),
            ),

            //Hour and Minutes as INTEGERS

            Text(hour.toString() + ':' + minutes.toString(),
              style: TextStyle(
                  
                fontSize: 15,
                color: Colors.white,

                ),  
  
            ),
          ],
        ));
  }
}
