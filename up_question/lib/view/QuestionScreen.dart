import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QuestionScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Stack(
      children: <Widget>[
        // The card widget with top padding,
        // incase if you wanted bottom padding to work,
        // set the `alignment` of container to Alignment.bottomCenter
        new Container(
          alignment: Alignment.topCenter,
          padding: new EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.05
          ),
          child: new Container(
            width: 330, // TODO: mudar para em função de ecrã
            height: 540, // TODO: mudar para em função de ecrã
            // height: MediaQuery.of(context).size.height * 0.75,
            //width: MediaQuery.of(context).size.width * 0.85,
            child: new Card(
              color: Colors.white,
              elevation: 10.0,
              child: new Text(
                "Ask your Question!"
              )
            ),
          ),
        )
      ],
    );;
  }

}