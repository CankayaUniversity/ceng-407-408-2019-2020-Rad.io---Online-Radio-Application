import 'package:flutter/material.dart';
import 'package:tombradioapp/screens/wrapper.dart';
import 'package:provider/provider.dart'; //specify what stream we listen to
import 'package:tombradioapp/services/auth.dart';
import 'package:tombradioapp/models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value( //<User> returns either uid or null to indicate user login
      value: AuthService().user, //we are now listening to this stream inside the widget
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
