String validateEmail(String value) {
  if (value.length < 5) {
    return 'Short Email, insert a Valid Email';
  }

  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}
//https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
/*This regex will enforce these rules:

At least one upper case English letter, (?=.*?[A-Z])
At least one lower case English letter, (?=.*?[a-z])
At least one digit, (?=.*?[0-9])
At least one special character, (?=.*?[#?!@$%^&*-])
Minimum eight in length .{8,} (with the anchors)*/

String validatePassword(String value){

  Pattern pattern=r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$';

  RegExp regex = new RegExp(pattern);

  if(value.length<6){
    return 'Short Password';
  }
  if (!regex.hasMatch(value))
    return 'Enter Valid Password';
  else
    return null;
}

String validateUsername(String value){

  Pattern pattern=r'^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$';

  RegExp regex = new RegExp(pattern);

  if(value.length<3){
    return 'Short Username';
  }
  if (!regex.hasMatch(value))
    return 'Enter Valid Password';
  else
    return null;
}
