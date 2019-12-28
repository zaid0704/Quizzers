import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzers/Screens.dart/firstScreen.dart';
import 'package:toast/toast.dart';
import '../provider.dart/Auth.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
 
  final GlobalKey<FormState> key = GlobalKey();
  TextEditingController emailController  = TextEditingController();
  TextEditingController passController = TextEditingController();
  Widget build(BuildContext context) {
    final data = Provider.of<Auth>(context);
    print("Here si ${data.ttoken}");
    return 
    data.ttoken?firstScreen():FutureBuilder(
      future:data.autoLogin(context) ,
      builder: (con,res)=>res.connectionState == ConnectionState.done?
      res.data==false? 
      
    SingleChildScrollView(
        child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black,Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
               Icon(Icons.people,color: Colors.yellow,size: 40,),
               SizedBox(height: 20,),
               Text('Quizzers',style: TextStyle(fontFamily: 'Quicksand',fontSize: 25,color:Colors.yellow,fontWeight: FontWeight.bold),),
               SizedBox(
                 height: 40,
               ),
              Form(
                key: key,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child:  TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        style: TextStyle(fontFamily: 'Quicksand',fontSize: 18,color: Colors.yellow),
                        
                        validator: (val){
                          if (val.isEmpty ||!val.contains('@gmail.com'))
                           {
                             return 'Invalid Email';
                           
                           }
                        },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                   borderSide: BorderSide(color: Colors.yellow),
                   ), 
               
                hintStyle: TextStyle(color: Colors.yellow,fontFamily: 'Quicksand'),
               focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.all(Radius.circular(10.0)),
               borderSide: BorderSide(color: Colors.yellow),
        ),
                        labelStyle: TextStyle(fontFamily: 'Quicksand',fontSize: 15,color: Colors.yellow),
                        labelText: 'Email Id',
                        // helperText: 'abc0000@gmail.com',
                        helperStyle: TextStyle(fontFamily: 'Quciksand',color: Colors.yellow),
                      ),
                    ),
                    ),
                   

                   Padding(
                      padding: const EdgeInsets.all(20),
                      child:  TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: passController,
                        style: TextStyle(fontFamily: 'Quicksand',fontSize: 18,color: Colors.yellow),
                        
                        validator: (val){
                          if (val.isEmpty )
                           {
                             return 'Invalid Password';
                           
                           }
                        },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                   borderSide: BorderSide(color: Colors.yellow),
                   ), 
               
                hintStyle: TextStyle(color: Colors.yellow,fontFamily: 'Quicksand'),
               focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.all(Radius.circular(10.0)),
               borderSide: BorderSide(color: Colors.yellow),
        ),
                        labelStyle: TextStyle(fontFamily: 'Quicksand',fontSize: 15,color: Colors.yellow),
                        labelText: 'password',
                        hintText: 'abc@123',
                        helperStyle: TextStyle(fontFamily: 'Quciksand',color: Colors.yellow),
                      ),
                    ),
                    ),
                    SizedBox(height: 30,),
                    RaisedButton(
                      padding: const EdgeInsets.only(left:30,right: 30),
                      child:Text('Login',style: TextStyle(fontFamily:'Quicksand',color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),) ,
                      onPressed: (){submit(data,emailController,passController);},
                      color: Colors.yellow,
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(15)
                      ),
                    ),
                  ],
                ),
              )
              ],
            ),
            
          ),
          //   child: 
          
           
          // ),
          
        ],
      )
      ):firstScreen():CircularProgressIndicator(),
      );
      }
  void submit(Auth data,TextEditingController email,TextEditingController password)async{
   if( key.currentState.validate()){
     Toast.show("Submit", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.TOP,textColor: Colors.yellowAccent);
     Scaffold.of(context).showSnackBar(SnackBar(
      content :Text('Proccessing ......',style: TextStyle(fontFamily: 'Quicksand',fontSize: 18,color: Colors.yellow),),
      backgroundColor: Colors.black,
     ));
      data.Login(email.text,password.text);
      print('Logging in .....');
     //Navigator.of(context).pushNamed('/firstScreen');
   }

  }
}