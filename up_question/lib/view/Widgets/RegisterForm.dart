import 'package:flutter/material.dart';
import 'package:up_question/controller/auth.dart';
import 'package:up_question/controller/validation.dart';
import 'package:up_question/model/User.dart';
import 'package:up_question/view/Widgets/Loading.dart';
import 'dart:ui';

class RegisterForm extends StatefulWidget {
  final Function toggleForm;

  const RegisterForm({this.toggleForm});

  @override
  _RegisterFormState createState() {
    return _RegisterFormState();
  }
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;

  final _passController = TextEditingController();
  User user = new User();

  // TODO: change later
  padding_fun() {
    if (MediaQuery.of(context).viewInsets.bottom -
            MediaQuery.of(context).size.height * 0.09 <
        0) return MediaQuery.of(context).viewInsets.bottom;
    return MediaQuery.of(context).viewInsets.bottom -
        MediaQuery.of(context).size.height * 0.09;
  }

  final double MAX_HEIGHT = 330;

  double height_fun() {
    if (MediaQuery.of(context).viewInsets.bottom == 0) return MAX_HEIGHT;
    double height = MediaQuery.of(context).size.height;

    // height without SafeArea
    var padding = MediaQuery.of(context).padding;

    // height without status and toolbar
    // TODO: 26 macro de baixo
    double utilHeight =
        height - padding.top - kToolbarHeight - padding.bottom - 26;

    double _height = utilHeight - MediaQuery.of(context).viewInsets.bottom;
    return (_height > MAX_HEIGHT) ? MAX_HEIGHT : _height;
  }

  @override
  Widget build(BuildContext context) {
    UnderlineInputBorder _underlineBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0),
    );
    return Padding(
      padding: EdgeInsets.only(bottom: padding_fun()),
      child: new Form(
          key: this._formKey,
          child: new Container(
            color: Color(0xAF000000), // TODO: macro
            width: MediaQuery.of(context).size.width,
            height: height_fun(),
            child: loading
                ? Loading()
                : SingleChildScrollView(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20, top: 26, bottom: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: 0, right: 2, left: 2, bottom: 5),
                            enabledBorder: _underlineBorder,
                            focusedBorder: _underlineBorder,
                            errorBorder: _underlineBorder,
                            filled: true,
                            hintText: 'Email',
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.7)),
                            helperText: ' ',
                          ),
                          validator: validateEmail,
                          onSaved: (val) => setState(() => user.email = val),
                          style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        new TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: 0, right: 2, left: 2, bottom: 5),
                            enabledBorder: _underlineBorder,
                            focusedBorder: _underlineBorder,
                            errorBorder: _underlineBorder,
                            filled: true,
                            hintText: 'Username',
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.7)),
                            helperText: ' ',
                          ),
                          validator: validateUsername,
                          onSaved: (val) => setState(() => user.username = val),
                          style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        new TextFormField(
                          controller: _passController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: 0, right: 2, left: 2, bottom: 5),
                            enabledBorder: _underlineBorder,
                            focusedBorder: _underlineBorder,
                            errorBorder: _underlineBorder,
                            filled: true,
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.7)),
                            helperText: ' ',
                          ),
                          validator: validatePassword,
                          onSaved: (val) => setState(() => user.password = val),
                          style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        new TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: 0, right: 2, left: 2, bottom: 5),
                            enabledBorder: _underlineBorder,
                            focusedBorder: _underlineBorder,
                            errorBorder: _underlineBorder,
                            filled: true,
                            hintText: 'Confirm Password',
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.7)),
                            helperText: ' ',
                          ),
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Please confirm your Password';
                            if (value != _passController.text)
                              return 'Passwords do not match';
                              //To silence warning
                            return null;
                          },
                          //onSaved: (val) => setState(() => user.password = val),
                          style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        new ButtonTheme(
                          minWidth: double.infinity,
                          height: 44,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: Color(0xFF353535),
                            textColor: Colors.white,
                            onPressed: () async {
                              final form = _formKey.currentState;

                              if (form.validate()) {
                                form.save();
                                setState(() => loading = true);

                                dynamic result = await _auth.register(
                                    user.email, user.username, user.password);

                                setState(() => loading = false);

                                if (result != null) {
                                  _showDialog(context, 'Register Successful');
                                  widget.toggleForm();
                                } else {
                                  _showDialog(context, 'Register Failed');
                                }
                              }
                            },
                            child: Text(
                              'Create Your Account',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: GestureDetector(
                            key: Key('AlreadyHasAccount'),
                            onTap: () {
                              widget.toggleForm();
                            },
                            child: Text(
                              'Already have an account?',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          )),
    );
  }

  _showDialog(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
