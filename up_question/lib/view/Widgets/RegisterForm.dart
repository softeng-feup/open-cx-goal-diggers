import 'package:flutter/material.dart';
import 'package:up_question/controller/auth.dart';
import 'package:up_question/controller/validation.dart';
import 'package:up_question/model/User.dart';
import 'package:up_question/view/Constants.dart';
import 'package:up_question/view/Widgets/Loading.dart';
import 'package:up_question/view/Widgets/GenericButton.dart';
import 'dart:ui';

class RegisterForm extends StatefulWidget {
  final Function toggleForm;

  const RegisterForm({this.toggleForm});

  @override
  _RegisterFormState createState() {
    return _RegisterFormState(toggleForm);
  }
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;
  final colorRegister = Color(0xAF000000);
  final Function toggleForm;
  //SHOW/HIDE PASSWORD AND CONFIRMPASSWORD
  bool _obscurePassword;
  bool _obscureConfirmPassword;

  _RegisterFormState(this.toggleForm);

  @override
  void initState() {
    super.initState();
    _obscurePassword = true;
    _obscureConfirmPassword = true;
  }
  //SHOW/HIDE PASSWORD

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
                        new TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            contentPadding:
                                Constants.authenticationFormFieldPadding,
                            enabledBorder: _underlineBorder,
                            focusedBorder: _underlineBorder,
                            errorBorder: _underlineBorder,
                            filled: true,
                            hintText: 'Email',
                            hintStyle: Constants.authenticationHintStyle,
                            helperText: ' ',
                          ),
                          validator: validateEmail,
                          onSaved: (val) => setState(() => user.email = val),
                          style: Constants.authenticationInputTextStyle,
                        ),
                        new TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding:
                                Constants.authenticationFormFieldPadding,
                            enabledBorder: _underlineBorder,
                            focusedBorder: _underlineBorder,
                            errorBorder: _underlineBorder,
                            filled: true,
                            hintText: 'Username',
                            hintStyle: Constants.authenticationHintStyle,
                            helperText: ' ',
                          ),
                          validator: validateUsername,
                          onSaved: (val) => setState(() => user.username = val),
                          style: Constants.authenticationInputTextStyle,
                        ),
                        Stack(
                          children: <Widget>[
                            TextFormField(
                              controller: _passController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                contentPadding:
                                    Constants.authenticationFormFieldPadding,
                                enabledBorder: _underlineBorder,
                                focusedBorder: _underlineBorder,
                                errorBorder: _underlineBorder,
                                filled: true,
                                hintText: 'Password',
                                hintStyle: Constants.authenticationHintStyle,
                                helperText: ' ',
                              ),
                              validator: validatePassword,
                              onSaved: (val) =>
                                  setState(() => user.password = val),
                              style: Constants.authenticationInputTextStyle,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                padding: EdgeInsets.only(bottom: 30.0),
                                icon: Icon(
                                  !_obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                  size: 25.0,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                        Stack(
                          children: <Widget>[
                            TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _obscureConfirmPassword,
                              decoration: InputDecoration(
                                contentPadding:
                                    Constants.authenticationFormFieldPadding,
                                enabledBorder: _underlineBorder,
                                focusedBorder: _underlineBorder,
                                errorBorder: _underlineBorder,
                                filled: true,
                                hintText: 'Confirm Password',
                                hintStyle: Constants.authenticationHintStyle,
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
                              style: Constants.authenticationInputTextStyle,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                padding: EdgeInsets.only(bottom: 30.0),
                                icon: Icon(
                                  !_obscureConfirmPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                  size: 25.0,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmPassword =
                                        !_obscureConfirmPassword;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                        new GenericButton(
                            'Create Your Account',
                            user,
                            loading,
                            _formKey,
                            _auth,
                            Key('Create Your Account'),
                            toggleForm,
                            null,
                            null,
                            null),
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
}
