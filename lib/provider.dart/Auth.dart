import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
class Auth with ChangeNotifier {
  
  String emailId;
  
  DateTime expiryDate;
  String token;
  
  bool get ttoken{
    if ( expiryDate!=null&& expiryDate.isAfter(DateTime.now()))
    {
      
     return true;}
    
    else
     return false;
     
  }
  Future<void> Login (String email,String password)async{
    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAsvF2cIm4aEisotyT9CaVECjUQRvdz07A';
    final http.Response response = await http.post(url,body:json.encode({
      'email':email,
      'password':password,
      'returnSecureToken':true
    }));
    
    final extractData = json.decode(response.body);
    token = extractData['idToken'];
    
    emailId = extractData['localId'];
    expiryDate  = DateTime.now().add(Duration(seconds: int.parse(extractData['expiresIn'])));
    final prefs  = await SharedPreferences.getInstance();
    final userData = json.encode({
      'token':token,
      'userId':emailId,
      'expiryDate':expiryDate.toIso8601String(),
    });
    
    prefs.setString('userData', userData);
    prefs.setString('logOut','no');
    print('Success');
    notifyListeners();
  }
  Future<bool> autoLogin(BuildContext context)async{
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey('userData')) {
      print('autoLogin');
      final map = json.decode(prefs.getString('userData')) as Map<String,Object> ;
      token = map['token'];
      emailId = map['userId'];
      expiryDate = DateTime.parse( map['expiryDate']);
            if(expiryDate!=null&& expiryDate.isAfter(DateTime.now()))
       {
         print('Expiry date is $expiryDate');
         return true;
       }
        
    }
    //RToast.show("AutoLogin returned False",context,duration: Toast.LENGTH_LONG,gravity: Toast.TOP,textColor: Colors.white);
    
    return false;


  }
  Future<void> logout(BuildContext context)async {
    print('called ..');
    final prefs =await SharedPreferences.getInstance();
    if(prefs.containsKey('userData'))
     {
       prefs.remove('userData');
       print('cleared');
     }
     if(prefs.containsKey('userData')){
       print('here the prob');
     }
     if(prefs.containsKey('logOut'))
      {
        prefs.setString('logOut', 'yes');
      }
     token = null;
     expiryDate = null;
     emailId = null;
     print('expiry date is $expiryDate');
     Navigator.of(context).pushReplacementNamed('/');
  }

  String get myToken{
    return token;
  }
  String get myUserId {
    return emailId;
  }
}