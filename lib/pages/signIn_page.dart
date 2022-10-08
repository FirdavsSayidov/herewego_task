import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego_task/model/pref_model.dart';
import 'package:herewego_task/pages/SignUp_page.dart';
import 'package:herewego_task/pages/home_page.dart';
import 'package:herewego_task/services/auth_services.dart';
import 'package:herewego_task/services/utils_services.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  static const String id = 'SignInPage';

  @override
  State<SignInPage> createState() => _SigInPageState();
}

class _SigInPageState extends State<SignInPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false;
  doLogin(){
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    if(email.isEmpty || password.isEmpty) return;

    setState(() {
      isLoading = true;
    });
    AuthServices.signInUser(context, email, password).then((value) => {
      _getFireBaseUser(value)
    });
  }
  _getFireBaseUser(User? firebaseuser) async {
    setState(() {
      isLoading = false;
    });
    if(firebaseuser != null){
      await Prefs.saveUserId(firebaseuser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
    }
    else{
      Utils.fireToast('CHeck your email or password');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email'
              ),
            ),
            TextField(obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Password'
              ),
            ),
           isLoading ?
        CircularProgressIndicator(): SizedBox.shrink(),
            SizedBox(height: 10,),
            Container(
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red
                ),
                onPressed: (){
              doLogin();
                },
                child: Text('Sign In'),
              ),
            ),
            SizedBox(height: 20,),
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Don`t have an account?'),
                TextButton(onPressed: (){
                  Navigator.pushReplacementNamed(context, SignUpPage.id);
                }, child: Text('Sign Up'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
