import 'package:flutter/material.dart';
import 'body_widget.dart';

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Node Server Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Client',style: TextStyle(color: Colors.white),
          ),
        ),
        body: BodyWidget(),
      ),
    );
  }
}