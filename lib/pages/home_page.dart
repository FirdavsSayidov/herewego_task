import 'package:flutter/material.dart';
import 'package:herewego_task/pages/signIn_page.dart';
import 'package:herewego_task/services/auth_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
  static const String id = 'HomePage';
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        titleTextStyle: TextStyle(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Container(

        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
             AuthServices.removeUser(context);
            }, child: Text('Logout'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red
            ),
            ),
            Container()
          ],
        ),
      ),
    );
  }
}
