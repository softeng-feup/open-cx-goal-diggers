import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/LoginForm.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text( 'UpQuestion' ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  // red box
                  child: Text(
                    '<Programming> 2020',
                    style: TextStyle(
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                      fontSize: 30,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(125, 0, 0, 0),
                        ),
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 10.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                ),
                top: 85,
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.width * 0.25, // TODO: depois ver este valor hardcoded
                child: LoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}