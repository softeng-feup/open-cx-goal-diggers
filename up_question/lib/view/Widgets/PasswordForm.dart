import 'package:flutter/material.dart';
import 'package:up_question/controller/auth.dart';
import 'package:up_question/model/User.dart';

import 'Loading.dart';

class PasswordForm extends StatefulWidget {
  final Function toggleForm;

  const PasswordForm({this.toggleForm});

  @override
  _PasswordFormState createState() {
    return _PasswordFormState();
  }
}

class _PasswordFormState extends State<PasswordForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  User user = new User();
  final AuthService _auth = AuthService();
  bool loading = false;
  final double MAX_HEIGHT = 185;

  padding_fun() {
    if (MediaQuery.of(context).viewInsets.bottom -
            MediaQuery.of(context).size.height * 0.09 <
        0) return MediaQuery.of(context).viewInsets.bottom;
    return MediaQuery.of(context).viewInsets.bottom -
        MediaQuery.of(context).size.height * 0.09;
  }

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
                        TextFormField(
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
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Please enter your username';
                          },
                          onSaved: (val) => setState(() => user.email = val),
                          style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        //Login button
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: ButtonTheme(
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
                                  dynamic result =
                                      await _auth.resetPassword(user.email);

                                  setState(() => loading = false);

                                  _showDialog(context, 'Email Sent to Reset Password');
                                  widget.toggleForm();
                                }
                              },
                              child: Text(
                                'Reset Password',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //Button of twitter login
                        ButtonTheme(
                          height: 0,
                          child: RaisedButton(
                            color: Color(0x00353535),
                            textColor: Colors.white,
                            onPressed: () {
                              widget.toggleForm();
                            },
                            child: Text('Login with Account'),
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
