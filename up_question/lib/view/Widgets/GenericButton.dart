import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class GenericButton extends StatefulWidget {
  final String textInButton;

  const GenericButton(this.textInButton);

  @override
  _GenericButtonState createState() {
    return _GenericButtonState();
  }
}

class _GenericButtonState extends State<GenericButton> {

  _GenericButtonState();

  void initState(){
    super.initState();
  }

  Widget build(BuildContext context){
    return Padding(
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







  }

}
