import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:up_question/controller/auth.dart';
import 'package:up_question/model/User.dart';
import 'package:up_question/view/Widgets/Loading.dart';
import 'package:up_question/view/Widgets/PasswordForm.dart';

class LoginForm extends StatefulWidget {
  final Function toggleForm;

  const LoginForm({this.toggleForm});

  @override
  _LoginFormState createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  User user = new User();
  final AuthService _auth = AuthService();
  bool loading = false;
  bool showPassResetForm = false;

  //SHOW/HIDE PASSWORD AND CONFIRMPASSWORD
  bool _obscurePassword;
  @override
  void initState() {
    _obscurePassword = true;
  }
  //SHOW/HIDE PASSWORD

  void togglePasswordForm() {
    setState(() => showPassResetForm = !showPassResetForm);
  }

  padding_fun() {
    if (MediaQuery.of(context).viewInsets.bottom -
            MediaQuery.of(context).size.height * 0.09 <
        0) return MediaQuery.of(context).viewInsets.bottom;
    return MediaQuery.of(context).viewInsets.bottom -
        MediaQuery.of(context).size.height * 0.09;
  }

  final double MAX_HEIGHT = 230;

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
    return showPassResetForm
        ? PasswordForm(
            toggleForm: togglePasswordForm,
          )
        : Padding(
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
                                key: Key('Email'),
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
                                      color:
                                          Color.fromRGBO(255, 255, 255, 0.7)),
                                  helperText: ' ',
                                ),
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Please enter your Email';
                                },
                                // TODO: mudar depois
                                onSaved: (val) =>
                                    setState(() => user.email = val),
                                style: new TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                              Stack(
                                children: <Widget>[
                                  TextFormField(
                                    key: Key('Password'),
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: _obscurePassword,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(top: 0, right: 2, left: 2, bottom: 5),
                                        enabledBorder: _underlineBorder,
                                        focusedBorder: _underlineBorder,
                                        errorBorder: _underlineBorder,
                                        filled: true,
                                        hintText: 'Password',
                                        hintStyle: TextStyle(
                                            color:
                                                Color.fromRGBO(255, 255, 255, 0.7)),
                                        helperText: ' ',
                                        /*suffixIcon: IconButton(
                                          icon: Icon(
                                            !_obscurePassword
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color:
                                                Theme.of(context).primaryColorDark,
                                            size: 18.0,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscurePassword = !_obscurePassword;
                                            });
                                          },
                                        )*/),
                                    validator: (value) {
                                      if (value.isEmpty)
                                        return 'Please enter your Password';
                                    },
                                    onSaved: (val) =>
                                        setState(() => user.password = val),
                                    style: new TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      padding: EdgeInsets.only(bottom: 30.0),
                                      icon: Icon(
                                        !_obscurePassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color:
                                        Theme.of(context).primaryColorDark,
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
                              //Login button
                              Padding(
                                key: Key('LOGIN'),
                                padding: const EdgeInsets.only(bottom: 20),
                                child: ButtonTheme(
                                  minWidth: double.infinity,
                                  height: 44,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    color: Color(0xFF353535),
                                    textColor: Colors.white,
                                    onPressed: () async {
                                      final form = _formKey.currentState;

                                      if (form.validate()) {
                                        form.save();

                                        setState(() => loading = true);
                                        dynamic result = await _auth.signIn(
                                            user.email, user.password);

                                        setState(() => loading = false);

                                        if (result != null) {
                                          if (!result.isEmailVerified)
                                            _showDialog(context,
                                                'Please Confirm your Email');
                                          else {
                                            _showDialog(
                                                context, 'Login Successfull');
                                            Navigator.pushReplacementNamed(
                                                context, '/SchedulePage');
                                          }
                                        } else {
                                          _showDialog(context, 'Login Failed');
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      widget.toggleForm();
                                    },
                                    child: Text('No account yet? Create one',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      togglePasswordForm();
                                    },
                                    child: Text('Forgot password?',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
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
