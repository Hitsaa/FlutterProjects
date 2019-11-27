/*
the name provider might be a little bit surprising.
When I say that we're going to make an inherited widget I mean to say that we're going to make a custom
widget that's going to extend from inherited widget. So the thing that you and I or the actual class that we're going to make
to kind of implement this inherited widget is going to be called the provider because it's providing an instance of the block to this widget
and everything underneath it. (video 15.4)
 */
import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
  final bloc = Bloc();

  Provider({Key key, Widget child}) : super(key: key, child: child);
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  static Bloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
    /*
    whats role of this function?
    you'll notice in this diagram(video 15.5) I put down some custom widgets down here as well.
    Now as you well know by this point every time we make a new widget we place it into a separate file
    so you can imagine that custom widget 1 is going to be its own dart file custom widget, custom widget 3 is in its own dart file custom widget and so on.
    So the scope of log in screen right here is completely 100 percent separates and decoupled from the scope of this custom widget number 3.
    but we're saying that we need to somehow give access to our bloc to custom widget number three. So a custom widget 3 down here has to somehow be able to reach back way up
    this hierarchy and magically at some point in time magically reach up and find this inherited widget that has the block assigned to it.

    the function is what allows our custom widget to read down here or any widget at some arbitrary data underneath the log in screen to just magically
    reach back up and somehow get a handle on the inherited widget and thus the block inside of it.
    So that's kind of my plain english definition of what it does without really saying how it does it.

    Now let's try going a little bit more into how it does it.

    So the how of this is all based on that context argument that we've been seeing all over the place without really saying anything about what it is to build context.
    you can think it of as being like a handle or an identifier that locates a particular widget inside of the widget hierarchy.
    So every widget that you and I create like the log in screen, custom widget1, custom widget2 , custom widget3 etc.,
    technically all these other built widgets has their own context and it's kind of this, which it's understanding of where it is located inside the overall widget hierarchy.

    Now context extend down underneath themselves.
    login screen has different context, container has different context, column has different context, textfield has different context, raised button has different context and so
    on. So the text field right here is aware of its own context and all contexts above it.

    you can kind of imagine that there is almost like a linked list sorts of context where each context knows about its parent.

    So this context inheritFromWidgetOfExactType(Provider) is essentially telling hey textfield I want you to look at your context and I want your parent to look at its parent
    and so on until it finds a widget of type Provider.

    as Provider -> So you'll notice that right here we say as provider that's a type code version. It tells dart that we want you to understand that whatever you get back
    this function right here, that is going to be an instance of Provider. Provider is of type InheritedWidget. You'll get it as you hover on provider.

    bloc -> We are getting the block property so that right here that block is going to be our block instance that we created on our provider.
     */
  }
}