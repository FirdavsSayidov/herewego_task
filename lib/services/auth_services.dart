

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:herewego_task/model/pref_model.dart';
import 'package:herewego_task/pages/signIn_page.dart';

class AuthServices{
  static final _auth  = FirebaseAuth.instance;

  static Future <User?> signInUser(BuildContext context,String email,String password) async{
    try{
     UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;
      print(user.toString());
      return user;
    }
    catch (e){
      print(e);
    }
    return null;
  }
  static Future <User?> signUpUser(BuildContext context,String name,String email,String password) async{
    try{
      var authResult  = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = authResult.user;
      print(user.toString());
      return user;
    }
    catch(e){
      print(e);
    }
    return null;
  }
  static Future<User?> removeUser(BuildContext context) async{
    _auth.signOut();
    Prefs.removeUserId().then((value) => {

      Navigator.pushReplacementNamed(context, SignInPage.id)
    });
  }
}