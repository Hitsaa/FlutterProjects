import 'package:video_chat/src/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewScreen extends StatelessWidget {
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text('Screen1'),
      ),
      body: Center(
        child: RaisedButton.icon(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => BackgroundImage()),
            );
          },
            icon: Icon(Icons.backspace), label: Text('Go Back', style: TextStyle(fontSize: 30.0),),
        ),
      ),
    );
  }
}