import 'package:flutter/material.dart';
import 'package:tombradioapp/screens/authenticate/sign_in.dart';
import 'package:tombradioapp/services/auth.dart';
import 'package:tombradioapp/sharedart/constants.dart';
import 'package:tombradioapp/sharedart/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView; //t11 7.36
  Register({this.toggleView}); //construct for the widget

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService(); //from auth.dart file to access "signInAnon" function
  bool loading = false;

  //Text field state for REGISTRATION
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
        title: Text('Sign up to Rad.io App'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
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
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Enter an email' : null, //null means valid
                  onChanged: (val) {
                    setState(() => email = val);
                  }
              ),
              SizedBox(height: 20.0), //Distancing
              TextFormField(  //PASSWORD
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
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
                color: Colors.deepOrange,
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate())
                    {
                      setState(() => loading = true);

                      dynamic result = await _auth.registerWithEmailandPassword(email, password);
                      if(result == null)
                        {
                          setState((){
                            error = 'Please supply a valid email';
                            loading = false;
                          });
                        }
                    }
                  else
                    {

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
