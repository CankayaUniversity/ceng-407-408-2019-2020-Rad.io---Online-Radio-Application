import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tombradioapp/screens/authenticate/authenticate.dart';
import 'package:tombradioapp/screens/home/home.dart';
import 'package:tombradioapp/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context); //everytime user logs in we get a user object back from THE STREAM indicating if in/out
    print(user);

    //return either Home or Authenticate Widget
    if(user == null)
      {
        return Authenticate();
      }
    else
      {
        return Home();
      }
  }
}
