import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'blocs/provider.dart';


class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return Provider(
      // wrapping the material app in our provider function
      // this will create a new instance of Bloc. which can access every thing inside material app and all child widgets.
      child: MaterialApp (
        title: 'Log Me In',
        home: Scaffold(
          body: LoginScreen(),
        ),
      ),
    );
  }
}