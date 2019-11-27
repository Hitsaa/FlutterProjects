import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Log Me In!',
      home: Scaffold(
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(title: Text('Nithara Technologies',style: new TextStyle(fontSize: 38.0, fontWeight: FontWeight.bold),)
        )
        ),
        body: LoginScreen(),
      ),
    );
  }

}