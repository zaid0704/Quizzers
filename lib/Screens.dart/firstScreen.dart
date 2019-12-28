import 'package:flutter/material.dart';
import 'package:quizzers/Screens.dart/quizz.dart';
import '../provider.dart/Auth.dart';
import 'package:provider/provider.dart';
class firstScreen extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    final tok = Provider.of<Auth>(context);
    final myToken = tok.myToken;
    final myUserId = tok.myUserId;
    return
    Center(
          child: GestureDetector(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.person,size: 50,color: Colors.yellow,),
              SizedBox(height: 80,),
              Text('Test your Skills ',style: TextStyle(color: Colors.yellow,fontSize: 25),),
              SizedBox(
                height: 40,
              ),
              Container(
            child: Text('Tap to Start !!',
            style: TextStyle(
              fontSize: 30,
              color: Colors.yellow
            ),
            ),

          ),
            ],
          ),
          
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Quizzs(myToken,myUserId)));
            //Navigator.of(context).pushNamed('/QuizzersPage',arguments: myToken);
          },
        ),
        );
  }
}