import 'package:flutter/material.dart';
import 'auth.dart';

  class LoginPage extends StatefulWidget
{ LoginPage({this.auth, this.onsignedIn}); //To pass from outside 
  final BaseAuth auth;
   final VoidCallback onsignedIn;
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
   }
  
  enum FormType{
    login,
    register,
    //play//for stream play
  
  }

  class _LoginPageState extends State<LoginPage>
  {
      final formKey= new GlobalKey<FormState>();

    String _email;
    String _password;
    FormType _formType = FormType.login;
    //FormType _play= FormType.play;

    bool validateAndSave()
      {  
        final form = formKey.currentState;      
        if(form.validate()){
          form.save();
          return true;
        }
        return false;

      }

      void validateAndSubmit() async {
        if(validateAndSave()){
          try{
            if(_formType == FormType.login){
              String userId = await widget.auth.signInWithEmailAndPassword(_email, _password);
          //FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
         print('User Signed in:  $userId');
            }else{
              String userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
               //FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
              print('User Registered: $userId');          
            }
            widget.onsignedIn();
          }
        catch(e){
          print('Error: $e');
        }
       }
      }
  
  
  void moveToRegister(){
    formKey.currentState.reset();
      setState(() {
        _formType=FormType.register;
      });
    
  }
void moveToLogin(){
  formKey.currentState.reset();
      setState(() {
        _formType=FormType.login;
      });
}

//ADD MOVE TO PLAY
 
  @override
  Widget build(BuildContext context) 
  {
     return new Scaffold(
       appBar:new AppBar(
         title: new Text('Rad.io Login Demo'),      
       ),
       body: new Container(
         child: new Form(
           key: formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
           children: buildInputs()+buildSubmitButton(),
          ),
         )
       )

     ); 
  }

  List<Widget> buildInputs(){
    return[
                    new TextFormField(
            decoration:new InputDecoration(labelText: 'Email'),
            validator: (value)=> value.isEmpty ? 'Email can\'t be empty':null,
            onSaved: (value) => _email=value,
            ),
            new TextFormField(
              decoration: new InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value)=> value.isEmpty ? 'Password can\'t be empty':null,
              onSaved: (value) => _password=value,
            ),
    ];
  }


    List<Widget> buildSubmitButton(){
          if(_formType == FormType.login){
          return[
                  new RaisedButton(
              child: new Text('Login',style: new TextStyle(fontSize:20.0)),
              onPressed: validateAndSubmit, 
            ),
            new RaisedButton(
              child: new Text('Create an account',style: new TextStyle(fontSize: 20.0)),
              onPressed: moveToRegister,
            ),
            //new RaisedButton (
              //child: new Text('Play Stream' ,style: new TextStyle(fontSize: 20.0)),
              //onPressed: moveToLogin,
              //),
          ];
          }else{
              return[
                  new RaisedButton(
              child: new Text('Create an account',style: new TextStyle(fontSize:20.0)),
              onPressed: validateAndSubmit, 
            ),
            new FlatButton(
              child: new Text('Have an account? Login',style: new TextStyle(fontSize: 20.0)),
              onPressed: moveToLogin,
            )
          ];
          }      
    }
}