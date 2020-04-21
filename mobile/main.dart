import 'package:flutter/material.dart';
//import 'login_page.dart';
import 'auth.dart';
import 'root_page.dart';
//import './arayuz/ilksayfa.dart';
//import './arayuz/hello.dart';

void main()
{
  runApp(new MyApp());  
  //runApp(new Hello());
} 

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    
    return  new MaterialApp(
      title: 'Flutter login demo',
      theme: new ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: new RootPage(auth: new Auth()),
      );
  }
 
}