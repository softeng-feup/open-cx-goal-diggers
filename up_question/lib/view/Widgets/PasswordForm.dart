import 'package:flutter/material.dart';
import 'package:up_question/controller/auth.dart';
import 'package:up_question/model/User.dart';
import 'package:up_question/view/Constants.dart';

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
            color: Constants.authenticationBackgroundColor,
            width: MediaQuery.of(context).size.width,
            height: height_fun(),
            child: loading
                ? Loading()
                : SingleChildScrollView(
                    padding: Constants.authenticationFormPadding,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            contentPadding: Constants.authenticationFormFieldPadding,
                            enabledBorder: _underlineBorder,
                            focusedBorder: _underlineBorder,
                            errorBorder: _underlineBorder,
                            filled: true,
                            hintText: 'Email',
                            hintStyle: Constants.authenticationHintStyle,
                            helperText: ' ',
                          ),
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Please enter your username';
                            else{
                              return null;
                            }
                          },
                          onSaved: (val) => setState(() => user.email = val),
                          style: Constants.authenticationInputTextStyle,
                        ),
                        //Login button
                        ButtonTheme(
                          minWidth: double.infinity,
                          height: 44,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: Constants.defaultBackgroundColor,
                            textColor: Colors.white,
                            onPressed: () async {
                              final form = _formKey.currentState;

                              if (form.validate()) {
                                form.save();

                                setState(() => loading = true);
                                await _auth.resetPassword(user.email);

                                setState(() => loading = false);

                                _showDialog(
                                    context, 'Email Sent to Reset Password');
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
                        //Button of twitter login
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              widget.toggleForm();
                            },
                            child: Text(
                              'Login with Account',
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
