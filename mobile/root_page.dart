import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'auth.dart';


class RootPage extends StatefulWidget{
  RootPage({this.auth});
  final BaseAuth auth;
  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus{
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage>{

  AuthStatus authStatus = AuthStatus.notSignedIn;////////Check again for imp.

  //@override
   initState() {   
    super.initState();
    widget.auth.currentUser().then((userId){ // "then" is for "await", instead of "await"
    setState(() {
      authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      print('Current User: '+ userId);
      });
    });
  }


void _signedIn(){

      setState(() {
        authStatus = AuthStatus.signedIn;
      });

}

void _signedOut(){

      setState(() {
        authStatus = AuthStatus.notSignedIn;
      });

}
  
  
  @override
  Widget build(BuildContext context) {
    switch (authStatus){
      case AuthStatus.notSignedIn:
      return new LoginPage(
        auth: widget.auth,
        onsignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
      return new HomePage(
        auth: widget.auth,
        onSignedOut: _signedOut,
      );
     
    } 
  }
}