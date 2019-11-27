import 'package:background_image_login/src/clicking_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    return /* Scaffold(
      appBar: new AppBar(
        title: Text('Video Chat App'),

      ),
      body: Column(
        children: <Widget>[ */
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/love-513a.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.center,
            child: ClickingEvent(),
          );
          /*
          Center(
              child: ClickingEvent()
          )
          */
//        ],
  //    ),
    //);
  }
}