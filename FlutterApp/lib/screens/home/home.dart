import 'package:flutter/material.dart';
import 'package:tombradioapp/services/auth.dart';


//Logged in
class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: Text('Welcome To Rad.io'),
        backgroundColor: Colors.orange[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async{
              await _auth.signOut(); //LOGOUT WHEN PRESSED
            },
          )
        ],
      ),
    );
  }
}
