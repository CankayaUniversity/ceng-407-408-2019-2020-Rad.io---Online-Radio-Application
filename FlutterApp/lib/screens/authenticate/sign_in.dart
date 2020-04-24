import 'package:flutter/material.dart';
import 'package:tombradioapp/screens/authenticate/authenticate.dart';
import 'package:tombradioapp/screens/authenticate/register.dart';
import 'package:tombradioapp/services/auth.dart';
import 'package:tombradioapp/sharedart/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView; //t11 7.36
  SignIn({this.toggleView}); //construct for the widget

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService(); //from auth.dart file to access "signInAnon" function
  bool loading = false;

  //Text field state for SIGNING IN
  final _formKey = GlobalKey<FormState>();
  String error = '';

  String email = '';
  String password = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
        elevation: 0.0,
        title: Text('Sign in to Rad.io App'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person_add),
            label: Text('Register'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField( //USER
                  decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 5.0)
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null, //null means valid
                onChanged: (val) {
                  setState(() => email = val);
                }
              ),
              SizedBox(height: 20.0), //Distancing
              TextFormField(  //PASSWORD
                  decoration: InputDecoration(
                    hintText: 'Password',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 5.0)
                    ),
                  ),
                  validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                }
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.green,
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate())
                  {
                    setState(() => loading = true); //LOADING

                      dynamic result = await _auth.signInWithEmailandPassword(email, password);
                    if(result == null)
                    {
                      setState((){
                        error = 'COULD NOT SIGN IN WITH THOSE CREDENTIALS';
                        loading = false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text (
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),

            ],
          ),
        ),
      ),
    );
  }
}



//RaisedButton(
//child: Text('Sign in anon'),
//onPressed: () async {
//dynamic result = await _auth.signInAnon(); //"dynamic" cuz can be null or firebase user
//if(result == null)
//{
//print('Error signing in');
//}
//else
//{
//print('Signed successfully');
//print(result.uid); //Shows USER ID
//}
//}
//),