import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens/screen1.dart';

class ClickingEvent extends StatefulWidget {
  _ClickingEventState  createState() => _ClickingEventState();
}

class _ClickingEventState extends State<ClickingEvent> {
  var _isMale = true;

  @override
  Widget build(BuildContext context) {
    return Material(       //earlier I was returning Container but texts were showing underline. Then Replacing it with Material solved the issue.
      type: MaterialType.transparency,
      child: Container(
        padding: EdgeInsets.only(top: 300),
        child: Column(
          children: <Widget>[
            Text('Interested In ?',style: TextStyle(fontStyle: FontStyle.italic,fontSize: 30.0,),),
            Container(margin: EdgeInsets.only(top: 50),),
            content(),
            Container(margin: EdgeInsets.only(top: 30),),
            selectButton(),
            ],
         )
      ),
    );
  }

  Container _buildSelect({String text, Color background, Color textColor}) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0), color: background),
      child: Center(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 25.0,),
          ),
      ),
    );
  }

  Widget _buildGenderSelect({String gender, bool selected}) {
    var button = selected
        ? _buildSelect(
        text: gender, textColor: Colors.black, background: Colors.white)
        : _buildSelect(
        text: gender, textColor: Colors.black, background: Colors.purple);

    return GestureDetector(
      child: button,
      onTap: () {
        setState(() {
          _isMale = !_isMale;
        });
      },
    );
  }

  Widget content() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      _buildGenderSelect(gender: "Male", selected: _isMale),
      _buildGenderSelect(gender: "Female", selected: !_isMale),
    ]);
  }

  Widget selectButton()
  {
    return Container(
      padding: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0)),
      child: RaisedButton.icon(
        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => NewScreen()),
            );
          },
        splashColor: Colors.yellowAccent,
        icon: Icon(Icons.play_arrow),
        label: Text('Start', style:TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0,
              ),
            ),
        shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0), side: BorderSide(color: Colors.red),
          ),
        ),
      );
    //);
  }
}
