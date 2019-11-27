import 'package:flutter/material.dart';
import 'validation_mixin.dart';

class LoginScreen extends StatefulWidget {
  createState() {
    return LoginScreenState();
  }
}

//class LoginScreenState extends State<LoginScreen> {
class LoginScreenState extends State<LoginScreen> with ValidationMixin{
  final formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
/*
Here's the form state class and now that we have a direct reference to the instance of forms state that
is created when we make our form we can look at all the different properties that are associated with
this thing in all the different methods that are associated with it as well.
So whereas before you and I could really only get access to the different constructors that are associated
with all these different widgets we now have the ability to reference all these properties and call
all these methods things to the global key that we set up right here.

So again the global key gives us the ability to reference a very specific widget and reference properties
and call methods that are associated with that widget.
So in the case of our foreign state class we can look at the different methods that are associated with this thing.
*/

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      //child: Text('Login Screen!!!')
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            emailField(),
            passwordField(),
            Container(margin: EdgeInsets.only(top: 25.0)),

            SubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
      decoration: InputDecoration(
        labelText: 'Email Address',
        labelStyle: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
        hintText: 'you@example.com',
        hintStyle: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5),
      ),
     /* validator: (String value) {
        //return null if valid otherwise returns a string with error message
        /*
          The validator function right here is what is actually responsible for looking out the value that has
          been entered into the text form fields and saying whether or not it is valid.
           */
        if(!value.contains('@')) {
          return 'Please enter a valid email';
        }
        //return null; // doesn't require this as by default it returns null
      },
      */
        validator: validateEmail,
        onSaved: (String value) {
        //print(value);
          email = value;
    },
    );
  }

  Widget passwordField() {
    return TextFormField(
      style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
        hintText: 'Password',
        hintStyle: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5),
      ),
      /*validator: (String value){
         if(value.length < 6) {
           return 'Password must be atleast 6 characters';
         }
      },
      */
        validator: validatePassword,
      onSaved: (String value) {
        //print(value);
        password = value;
      },
    );
  }

  Widget SubmitButton() {
    return RaisedButton(
      color: Colors.blueAccent,
      child: Text('Login',style: TextStyle(fontSize: 30)
      ),
      onPressed: () {
        //print(formKey.currentState.validate());
        // formKey.currentState.reset(); it will reset without giving any error message.
        if(formKey.currentState.validate()) {
          formKey.currentState.save();
          print('Its time to post $email and $password to my API');
          //take both email and password and post them to some API
        }
      },
    );
  }
}

/*
whenever submit button gets pressed I'm going to attempt to reference the form state instance and call the reset method on it.
to do so I'm going to reference first the form key which is going to give us a reference to the form
state instance that is created to kind of back up or represent our form on the screen.
 */

/*
Whenever we create an instance of form not only are we getting the kind of core form widget that render
something on screen to the device but it's also behind the scenes creating a form state instance the
same kind of class that is created by our log in screen state right here.
Remember when we create a stateful widget we get the kind of widget that represents our widget on the
screen the device or the class instance that represents our stuff on screen of the device.
This widget is right here in this class gets created and thrown away every time our application is rendered.
This form gets created and thrown away every time our application renders.
But the actual values that are stored within our form are persisted within this form state object.
So that's why our situation is a little bit more complicated when it comes to that global key.
We don't want to associate the global key with the form the information that you and I care about like
the status of all those input fields and whether or not they are valid is actually stored with the form state not the form.
we want to create a global key and we want to associate that global key with the form state not the original form.
 */