import 'dart:async';
import '../blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Object with Validators{
  //final _emailController = StreamController<String>.broadcast();    // for listening streams multiple times we have to use broadcast.
  //final _passwordController = StreamController<String>.broadcast();

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  
  //Add data to stream
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password => _passwordController.stream.transform(validatePassword);
  Stream<bool> get submitValid =>
      Observable.combineLatest2(email,password, (e,p) => true);
  /*
  The third argument is going to be a function that we can use to kind of combine the values that are
  coming across the e-mail and the password streams.
  The third argument right here is supposed to be a value coming across stream 1 and evaluate coming across
  stream 2 and then whatever we return from that function will be the value that gets issued on our New Stream.
   */
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  submit() {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;

    print('Email is $validEmail');
    print('Password is $validPassword');
  }

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}

//commenting below line so that we can create our scoped instance.
//final bloc = Bloc();  // Single Global instance

