import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:up_question/controller/auth.dart';
import 'package:up_question/main.dart';
import 'package:up_question/model/User.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  User user = new User();

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder _roundedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    );
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: new Form(
          key: this._formKey,
          child: new Container(
            color: Color(0xAF000000), // TODO: macro
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  EdgeInsets.only(left: 20.0, right: 20, top: 36, bottom: 36),
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
                              if (value.isEmpty)
                                return 'Please enter your username';
                            },
                            onSaved: (val) => setState(() => user.email = val),
                            style: new TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),

                      //Button to submit the login to firebase
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: new ButtonTheme(
                          height: 44,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: Color(0xFF353535),
                            // TODO: por em const
                            textColor: Colors.white,

                            onPressed: () async {
                              final form = _formKey.currentState;

                              if (form.validate()) {
                                form.save();
                                MyApp.database.users.add(user);

                                dynamic result = await _auth.signinemail(
                                    user.email, user.password);

                                if (result != null) {
                                  _showDialog(context);
                                  Navigator.pushNamed(context, '/SchedulePage');
                                } else {
                                  print("Erro");
                                }
                              }
                            },
                            child: Text(
                              'Login',
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

//Row that describes the widget containing the password
                  Row(
                    children: <Widget>[
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: new TextFormField(
                            //Hide text input
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            maxLines: 1,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              enabledBorder: _roundedBorder,
                              focusedBorder: _roundedBorder,
                              errorBorder: _roundedBorder,
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Password',
                              helperText: ' ',
                            ),
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Please enter your Password';
                            },
                            onSaved: (val) =>
                                setState(() => user.password = val),
                            style: new TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: new ButtonTheme(
                          height: 44,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: Color(0xFF353535),
                            // TODO: por em const
                            textColor: Colors.white,

                            onPressed: () async {
                              final form = _formKey.currentState;

                              if (form.validate()) {
                                form.save();

                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        user.email, user.password);

                                if (result == null) {
                                  print("Error");
                                }

                                _showDialog(context);
                              }
                            },
                            child: Text(
                              'Register',
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

                  //Button of twitter login
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      height: 44,
                      child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
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
          )),
    );
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Logging In')));
  }
}
