//22.35
import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  Widget build(context) {   //22.35
    return Column(      //22.36
    children: [
      ListTile(
          title: buildContainer(),
          subtitle: buildContainer(),
        ),
      Divider(height: 8.0),
    ],
   );
  }
//22.36
  Widget buildContainer() {
    return Container(
      color: Colors.grey[200],
      height: 24.0,
      width: 150,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),   //22.36
    );
  }
}