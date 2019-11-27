import 'dart:async';

class Validators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink) {
        if(email.contains('@')) {
          sink.add(email);
        }
        else {
          sink.addError('Enter a valid Email');
        }
      }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        if(password.length > 3) {
          sink.add(password);
        }
        else {
          sink.addError('Password must be at least 3 letters');
        }
      }
  );
}

/*
Now inside the class itself we had previously defined functions called validate email to validate password
that accepted some input and then returned the results of that validation.
But this time we want to create transformer's so we don't actually have to define these inside of functions.
And in fact we probably shouldn't define them inside of functions because if we find these in a function
then any time that we try to reuse this mixin we'll probably have to call that function again and build
a brand new stream transformer stream Transformers.
In reality can be reused as much as we want.
So rather than defining these things into some functions in this file I'm going to instead assign them
to some instance variables so we can just make one instance of this validators class or mixed in one
time and boom or get to go so inside of here I'm going to declare a new variable called validate email
will make this a stream transformer
from handlers and then inside they're will to find a handle data function that's going to be called
with a first argument of the incoming email so we'll call that number to simply email.
*/
