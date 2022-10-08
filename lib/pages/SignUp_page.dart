import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego_task/model/pref_model.dart';
import 'package:herewego_task/pages/home_page.dart';
import 'package:herewego_task/pages/signIn_page.dart';
import 'package:herewego_task/services/auth_services.dart';
import 'package:herewego_task/services/utils_services.dart';


class SignUpPage extends StatefulWidget {
   SignUpPage({Key? key}) : super(key: key);
  static const String id = 'SignUpPage';

  @override
  State<SignUpPage> createState() => _SignUpPageState();


}

class _SignUpPageState extends State<SignUpPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fullnameController = TextEditingController();
  var isLoading = false;
  doLogin(){

    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String fullname = fullnameController.text.toString().trim();
    if(email.isEmpty || password.isEmpty) return;
setState(() {
  isLoading =true;
});
   AuthServices.signUpUser(context, fullname, email, password).then((value) =>
   {
     _getFireBaseUser(value),
   });
  }
  _getFireBaseUser(User? firebaseUser)async{
    setState(() {
      isLoading = false;
    });
    if(firebaseUser != null){
      await Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
    }
    else{
      Utils.fireToast('Check all information');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller:fullnameController,
              decoration: InputDecoration(
                  hintText: 'FullName'
              ),
            ),
            TextField(controller: emailController,
              decoration: InputDecoration(

                  hintText: 'Email'
              ),
            ),
            TextField(controller:passwordController ,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Password'
              ),
            ),
            SizedBox(height: 10,),
            isLoading ?
            CircularProgressIndicator(): SizedBox.shrink(),
            Container(
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red
                ),
                onPressed: (){
                  doLogin();
                },
                child: Text('Sign Up'),
              ),
            ),
            SizedBox(height: 20,),
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Already have an account?'),
                TextButton(onPressed: (){
                  Navigator.pushReplacementNamed(context, SignInPage.id);
                }, child: Text('Sign In'))
              ],
            )
          ],
        ),
      ),
    );
  }
}

