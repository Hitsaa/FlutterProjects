import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class LoginScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: [
          emailField(),
          passwordField(),
          Container(margin: EdgeInsets.only(top: 25.0)),
          submitButton(),
          Container(margin: EdgeInsets.only(top: 20.0),),
          facebookButton(),
        ],
      ),
    );
  }

  Widget emailField() {
    return StreamBuilder(
      stream: bloc.email,
      builder: (BuildContext context, snapshot) //this snapshot argument right here contains whatever information just came across our stream.
      //whenever the builder function is called it gets invoked with whatever value came across the stream
      //that value gets wrapped up inside of the snapshot argument right here.
      //data is a property of snapshot as illustrated in documentation. If our stream emits a value like a normal value then that value will be present on the data property.
      //However if this stream emits an error then it will be present an error object. Presumably that will be emitted by that transformer we put together.
      //If there's an error means that there is a validation message that we need to show on the screen so to
      //the text property right here we want to look at the snapshots and if the snapshot has an error property
      //on it that means that there must be a validation error that just occurred and we want to take that error an assign it to error text.
    {
      return TextField(
        onChanged: bloc.changeEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'you@example.com',
          labelText: 'Email Address',
          errorText: snapshot.error,
          //don't write this
          //errorText: bloc.emailController.stream,
          //errorText: bloc.emailError, // this is better than above one
          )
        );
      }
    );
  }

      // Don't write this. The possible issue that we can face in future
      // when we try to implement everything as it is as mentioned in diagram.
      // video 10. Issues with Bloc Access
   /* onChanged: (newValue) {
      //bloc.emailController.sink.add(newValue);
      bloc.changeEmail(newValue); // this is better one than above
    },
   */

  Widget passwordField() {
     return StreamBuilder(
       stream: bloc.password,
       builder: (context, snapshot)
       {
        return TextField(
          onChanged: bloc.changePassword,
          obscureText: true,
          decoration: InputDecoration(
          hintText: 'Password',
          labelText: 'Password',
          errorText: snapshot.error,
        ),
      );
     }
   );
  }

  Widget submitButton() {
    return RaisedButton(
      child: Text('Login'),
      color: Colors.blue,
      onPressed: () {},
    );
  }

  Widget facebookButton() {
    return RaisedButton(
      child: Text('Continue with Facebook'),
      color: Colors.blue,
      onPressed: () {},
    );
  }
}

