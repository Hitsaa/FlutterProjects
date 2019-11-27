import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'validation_mixin.dart';

import 'signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder> {
        '/signup': (BuildContext context) => new SignupPage()
      },
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with ValidationMixin{

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      resizeToAvoidBottomPadding: false,
//we used this because when we added password field then due to some padding issues something unusual occurred on screen. so to
//avoid that we did resizeToAvoidBottomPadding false.
      body: Column(
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
                  padding: EdgeInsets.fromLTRB(260.0,175.0,0.0,0.0),
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
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0,bottom: 50.0),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    hintText: 'you@example.com',
                    hintStyle: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)
                    ),
                  ),
                ),
                SizedBox(height: 20.0), // this will increase the gap between email and password fields.
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)
                    ),
                  ),
                  obscureText: true,  // text hidden behing black dots.
                ),
                SizedBox(height: 5.0,), // gap between forgot password and password field.
//now when we click on forgot password then we will redirected to a new screen which will ask our mobile number or email to reset
//password. so we can't just add TextField here for that. so we will use Container
                Container(
                  alignment: Alignment(1.0,0.0),
//for doing right alignment on x axis (so that forgot password appears on the right side below password field), we will use alignment.
                  padding: EdgeInsets.only(top: 15.0, left: 20.0),
                  child: InkWell(
                    child: Text('Forgot Password',
                    style: TextStyle(
                        color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      decoration: TextDecoration.underline
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.0), // space between forgot password and login button
                Container(
                  height: 40.0,
                  child: Material(
// I am using material widget to define whole new material as a button
                    borderRadius: BorderRadius.circular(20.0),  // The left and right edges of login button will be circular
                    shadowColor: Colors.greenAccent,
                    color: Colors.green,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () {},
                      child: Center(
                          child: Text('LOGIN',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            ),
                          ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                Container(
                  height: 40.0,
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: ImageIcon(AssetImage('assets/facebook.png')),
                        ),
                        SizedBox(width: 10.0,),
                        Center(
                          child: Text('Log in with Facebook',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 15.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('New to ChatApp ?',
              style: TextStyle(
                fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(width: 5.0,),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/signup');
                },
                child: Text('Register',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}