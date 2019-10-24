import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:up_question/model/User.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _user = new User();

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder _roundedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    );
    return new Form(
        key: this._formKey,
        child: new Container(
          color: Color(0xAF000000), // TODO: macro
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20, top: 36, bottom: 36),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: new TextFormField(
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            enabledBorder: _roundedBorder,
                            focusedBorder: _roundedBorder,
                            errorBorder: _roundedBorder,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Username',
                            helperText: ' ',
                          ),
                          validator: (value) {
                            if (value.isEmpty) return 'Please enter your username';
                          },
                          onSaved: (val) => setState(() => _user.username = val),
                           style: new TextStyle( fontSize: 20.0,),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: new ButtonTheme(
                        height: 44,
                        child:RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Color(0xFF353535),
                        // TODO: por em const
                        textColor: Colors.white,
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (form.validate()) {
                            form.save();
                            //_user.save();
                            _showDialog(context);
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ButtonTheme(
                    minWidth: double.infinity,
                    height: 44,
                    child: RaisedButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      color: Color(0xFF2DAAE1), // TODO: por em const
                      textColor: Colors.white,
                      onPressed: () {
                        final form = _formKey.currentState;
                        if (form.validate()) {
                          form.save();
                          //_question.save();
                          _showDialog(context);
                        }
                      },
                      icon: Icon(EvaIcons.twitter),
                      label: Text(
                        'Login with Twitter',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Logging In')));
  }
}
