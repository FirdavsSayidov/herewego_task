
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:herewego_task/model/pref_model.dart';
import 'package:herewego_task/pages/SignUp_page.dart';
import 'package:herewego_task/pages/home_page.dart';
import 'package:herewego_task/pages/signIn_page.dart';
import 'package:herewego_task/services/utils_services.dart';

/*void main(){
  runApp(
    MaterialApp(
      home: MyApp(),
      routes: {
        HomePage.id:(context) => HomePage(),
        SignInPage.id:(context) => SignInPage(),
        SignUpPage.id:(context) => SignUpPage()
      },
    )
  );
}

class MyApp extends StatelessWidget {

const MyApp({super.key});
@override
  Widget build(BuildContext context){
  return FutureBuilder(
    future: Firebase.initializeApp(),
      builder: (context,snapshot)
  {
    if(snapshot.hasError)
      return Text('Somaething went wrong');



    if(snapshot.connectionState == ConnectionState.done){
      return const HomePage();
    }
    return Utils.Loading();
    //return const SignInPage();
  }

  );
}


}*/
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => print('Firebase ishga tushdi'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Widget _startPage() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          Prefs.saveUserId(snapshot.data!.uid);
          return HomePage();
        } else {
          Prefs.removeUserId();
          return SignInPage();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _startPage(),
      routes: {
        HomePage.id: (context) => HomePage(),
        SignInPage.id: (context) => SignInPage(),
        SignUpPage.id: (context) => SignUpPage(),
      },
    );
  }
}