import 'package:flutter/material.dart';
import './Screens.dart/AuthScreen.dart';
import './provider.dart/Auth.dart';
import 'package:provider/provider.dart';
import './Screens.dart/firstScreen.dart';
import './Screens.dart/quizz.dart';
void main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value:Auth() ,
        )
      ],
      child:MaterialApp(
      theme: ThemeData(
        fontFamily: 'Quicksand'
      ),
      routes: {
        // '/QuizzersPage':(ctx)=>Quizzs(),
        '/firstScreen':(cont)=>firstScreen(),
        '/AuthScreen':(ctx)=>AuthScreen()
      },
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(title: Text('Quizzers',
        textAlign: TextAlign.center ,style: TextStyle(color: Colors.yellow),),
        backgroundColor: Colors.black87,),
        body:AuthScreen()
        
    

    )));
    
  }
}