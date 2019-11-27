import 'package:flutter/material.dart';
import 'login_screen.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Log Me In!',
      home: Scaffold(
        resizeToAvoidBottomPadding: false,    //to avoid bottom overflow we used it.
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(title: Text('Video Chat',style: new TextStyle(fontSize: 38.0, fontWeight: FontWeight.bold),)
          )
        ),
        body:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
//we put this because if we don't put it here then the text we wrote "Welcome to Video Chat"  will be put in center and email
//section will be in left. Means alignment will be disturbed.
//Actually below we have container, in container we have stack and in stack we have another container where we have defined our
//text. out of this stack in outer container we put email field. so to keep everything aligned we use crossAxisAlignment.
            children: <Widget>[
            Container(
              child: Stack(
// The reason we used stack instead of couple of containers, widgets and text widgets is because they all come with some default
// padding. So if we want to use "Welcome to " and below it "Video Chat" we will have a long white space gap using those containers.
// so we used stack and couple of containers in the stack. Stack is generally used when we want to pile more than one widget one
//above the other. In containers we changed the padding and have different padding for all the containers. So we can actually
//customize the white space between them.
                children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0,110.0,0.0,0.0),
                  child: Text(
                  'Welcome To',
                  style: TextStyle(
                  fontSize: 50.0, fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15.0,175.0,0.0,0.0),
                  child: Text(
                    'Video Chat',
                    style: TextStyle(
                    fontSize: 50.0, fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                  Container(
                    padding: EdgeInsets.fromLTRB(300.0,175.0,0.0,0.0),
                    child: Text(
                      '.',
                      style: TextStyle(
                      fontSize: 50.0, fontWeight: FontWeight.bold, color: Colors.green,
                      ),
                    ),
                  ),
              ],
             ),
            ),
             SizedBox(height: 20.0),
             LoginScreen(),
            ],
      ),
      ),
    );
  }

}