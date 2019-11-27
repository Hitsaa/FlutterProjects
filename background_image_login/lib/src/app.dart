import 'package:flutter/material.dart';
import 'background.dart';

class MyApp extends StatelessWidget {
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'Video Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BackgroundImage(),
    );
  }
}