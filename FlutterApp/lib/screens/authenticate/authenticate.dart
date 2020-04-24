import 'package:flutter/material.dart';
import 'package:tombradioapp/screens/authenticate/register.dart';
import 'package:tombradioapp/screens/authenticate/sign_in.dart';

//Not Logged in
class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView()
  {
    setState(() => showSignIn = !showSignIn); //dont hardcode it -> "false" so it will keep it's state
  }

  @override
  Widget build(BuildContext context) {

    if(showSignIn)
      {
        return SignIn(toggleView: toggleView);
      }
    else
      {
        return Register(toggleView: toggleView);
      }
  }
}
