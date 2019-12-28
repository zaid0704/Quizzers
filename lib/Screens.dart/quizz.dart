import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import '../provider.dart/Auth.dart';
class Quizzs extends StatefulWidget {
  String myToken ;
  String myUserId;
  Quizzs(

    this.myToken,
    this.myUserId
  );

  @override
  _QuizzsState createState() => _QuizzsState();
}

class _QuizzsState extends State<Quizzs> {
  
 
 Map<String,dynamic> data ;
 int curr_level;
 int change_level = 0;
 int myScore ;
 int gameOver = 0;
  @override
  void initState() { 
    super.initState();
     getData(widget.myToken,widget.myUserId);
  }
  
   final databaseReference = FirebaseDatabase.instance.reference().child("level");
  TextEditingController controller = TextEditingController();
  Widget build(BuildContext context) {
    // final myToken = ModalRoute.of(context).settings.arguments as String;
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Quicksand'
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Text('Quizz',style: TextStyle(color: Colors.yellow),),
          actions: <Widget>[
            PopupMenuButton(
              icon: Icon(Icons.more_vert,color: Colors.yellow,),
              onSelected: (int val)async{
                if (val == 0 ) 
                 {
                  
                   await Provider.of<Auth>(context).logout(context);
                 }
              },
              elevation: 6.0,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context)=>[
                PopupMenuItem(
                  value: 0,
                  child: Text('Logout',style: TextStyle(fontFamily: 'Quicksand',fontSize: 18,fontWeight: FontWeight.bold),),
                )
              ]
            )
          ],
        ),
        body: gameOver == 1 ? AlertDialog(
            title: Text('Successfull'),
            content: Text('You are a genius , completed all questions '),
            actions: <Widget>[
              FlatButton(child: Text('Ok'),
              onPressed: (){
                Navigator.of(context).pop();
              },),
            ],
          ):data==null || change_level == 1?Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.yellow,
          ),):
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Level is : ${(curr_level)+1}',style: TextStyle(color:Colors.yellow,fontSize: 20,fontFamily: 'Quicksand'),),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
              data['question'],style: TextStyle(fontSize: 25,color: Colors.yellow,fontFamily: 'Quicksand'),
            ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20),
              child:  TextField(
                style: TextStyle(color: Colors.yellow),
                controller: controller,
                onSubmitted: (_){
                  if (controller.text == data['ans_question'])
                {
                  controller.clear();
                  Toast.show("Correct Answer", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.TOP,textColor: Colors.yellowAccent);
                  databaseReference.update({
                    '${widget.myUserId}':curr_level+1
                  });
                  getData(widget.myToken,widget.myUserId);
                  setState(() {
                   change_level = 1; 
                  });
                }
                else{
                   Toast.show("Wrong Answer", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.TOP,textColor: Colors.yellowAccent);
                }
                },
              decoration: InputDecoration(
                labelText: 'Answer',
                labelStyle: TextStyle(color: Colors.yellow,fontFamily: 'Quicksand'),
                 enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                   borderSide: BorderSide(color: Colors.yellow),
                   ), 
                hintText: 'Type Yor Answer Here !',
                hintStyle: TextStyle(color: Colors.yellow,fontFamily: 'Quicksand'),
               focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.all(Radius.circular(10.0)),
               borderSide: BorderSide(color: Colors.yellow),
        ),
              ),
            )
           
            ),
            SizedBox(
              height: 30,
            ),
            Text('Score : ${myScore}',style: TextStyle(color: Colors.yellow,fontSize: 20 ),)
          ],
        )
      ),
    );
  }
  Future<void> getData(String myToken,String myUserId)async{
    print('UID is $myUserId');
    final level =  'https://quzzres.firebaseio.com/level.json?auth=$myToken';
    http.Response level_res = await http.get(level);
    print('levels${json.decode(level_res.body)}');
    curr_level =(json.decode(level_res.body)['$myUserId']);
    print('Current lebel for uid $myUserId is :$curr_level');
   if(curr_level == 7)
    {
      setState(() {
       gameOver = 1 ; 
      });
    }
    print("Curr_level$curr_level");
    final url = 'https://quzzres.firebaseio.com/${curr_level}.json?auth=$myToken';
    http.Response response = await http.get(url);
    print(json.decode(response.body));
    setState(() {
      data = json.decode(response.body);
      change_level = 0;
      myScore = curr_level * 10 ; 
     
    });
    
 }
 
}

