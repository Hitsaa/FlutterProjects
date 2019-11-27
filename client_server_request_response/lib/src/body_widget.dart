import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:get_ip/get_ip.dart';

class BodyWidget extends StatefulWidget {
  @override
  BodyWidgetState createState() {
    // TODO: implement createState
    return new BodyWidgetState();
  }
}

class BodyWidgetState extends State<BodyWidget> {
  String serverResponse = 'Server response';

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Align(
       alignment: Alignment.topCenter,
       child: SizedBox(width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Send Request To server'),
              onPressed: () {
                _makeGetRequest();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(serverResponse),
            ),
          ],
        ),
       ),
      ),
    );
  }
  _makeGetRequest() async {
    Response response = await get(_localhost());
    setState(() {
      serverResponse = response.body;
      },
    );
  }

  Future<String> _localhost() async{
    String ipAddress = await GetIp.ipAddress;
    return ipAddress;
  }
}