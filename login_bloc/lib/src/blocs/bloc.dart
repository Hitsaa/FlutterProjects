import 'dart:async';
import '../blocs/validators.dart';

class Bloc extends Object with Validators{
  final _emailController = StreamController<String>();
  final _passwordController = StreamController<String>();
/*
Any time we create a stream controller we get a sync along with it and by default that sync stays open
and waits for events to be added for to it forever.
Now dart doesn't like to see it sinks open forever and wants to see you and I eventually close that
sync or clean it up.
When we are done with it now in our application you and I are never going to be truly done with these
sinks but nonetheless dart wants to see us out some code that's going to attempt to close those things
or clean them up after we are done with them.

So just to make d'arte happy at the bottom of our class we're going to add on a new method called Dispose

 */
  //Add data to stream
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password => _passwordController.stream.transform(validatePassword);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}

final bloc = Bloc();  // Single Global instance

/*
void main() {
  final bloc = Bloc();

  bloc.emailController.sink.add('slkghlshglshg'); // other
  bloc.changeEmail('alshflahh');
}
*/
/*
Remember we use a mixin by adding in the keyword with and then listing out the name of the mixin like
so now when we do it this time you'll notice that the word with turns red.
class Bloc with Validators (it turns red)

a mixin can't be used without an extends clause.
We cannot apply a mixin to a class without first extending it.
Now if we still want to use this mixin with the mix in syntax there's a very simple workaround.
We can either replace with extends and just have the class block extend the validators class
class Bloc extends Validators (it works fine)

One other possible solution to this.
If we really want to use validators as a mixin would be to have Bloc extend the darte base class the
absolute root class of all classes and side of Dart which is known as the object class.
And then we can apply the mixin to that like so.
class Bloc extends Object with Validators (it is very good method for using mixin.

So when a class block extends object object does not have any additional methods that block doesn't
already have.
So no changes are made to what the class block right here.

 */