import 'package:flutter/material.dart';
import '../models/image_model.dart';

class ImageList extends StatelessWidget {   //11.13

/*
Why stateless widget ?
 Is it going to have any instance variables that are going to be changed by the which itself.
 The image list that we are creating is going to be given a list of image model instances and we're going
 to have to definitely somehow like save that list of images inside this widget so that we can refer
 back to that list later on when our build method gets called or whatever else we're trying to do.
 So I think that we are going to have to know about that list of images inside this widget.
 And I think that without a doubt that list of images will change over time because we're going to be
 adding on no new images every time the user presses that button.
How ever this is the key part.
  However it is the parent widget of the app state that is changing that data.
  So our image list right here it is going to have an instance variable.
  I kind of will expect that to change over time but it's not the image List's job to change it.
  So because the image list right here is not changing that very well because it is not in charge of maintaining
  that list of images.
  We're going to make this a stateless widgets the image list is never going to try to change that list
  of images and it's never going to try to re render itself.
*/

  final List<ImageModel> images;
  /*
  we want a list that's going to contain image models and we want to call that images.  11.13
   */

  //why final keyword ?
  /*
  When we create a stateless widget, it contains data that should not change over time because when we create a stateless widget
  flutter is going to create that thing and then throw it away every time it tries to re render our application.
  So every time we call the build method inside of our app.dart file,we're going to be constantly creating new copies of the image
  list and throwing them away over and over again.
  So flutter wants to make sure that we should not change the value of images (as defined just above these comments) because in
  order to change images we have to create an entire new instance of the image list widget.
  So we have to add the final keyword in front of the type declaration.
   */

  ImageList(this.images);
  /*
  constructor method that's going to accept that list of images
   */

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
        itemBuilder: (context, int index){
          return buildImage(images[index]);
        },
        );
  }

  Widget buildImage(ImageModel image) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.all(20.0),
      //child: Image.network(images[index].url),
      //child: Image.network(image.url),
      child: Column(
        children: <Widget>[
          Padding(
            child: Image.network(image.url),
            padding: EdgeInsets.only(bottom: 8.0),
          ),
          Text(image.title),
        ],
      ),
    );
  }
}

/*
If we use the list view constructor directly then we're going to take a list of records and try to build
a single widget out of each one and we're going to create that entire array of widgets instantly.
So the instant our entire application renders to the screen of our device we're going to build out the
whole list of every single element inside of our list view.
So this is sometimes not the best approach.
From a performance perspective think about it.
If we have a list of like 5000 images we don't want to build out 5000 widgets the instant our application
loads up.

So very frequently we instead use this builder named constructor the list view builder constructor creates
Or C it works just a little bit differently in that it creates a list of widgets that are created on demand.
The term on demand here means to say that as a user is scrolling around this list of records on our
their mobile device only when the user starts to reach the end of that list.
Will this list do you build or start to kick in and render more widgets to go on the screen so we can
think of list view builder as being a little bit more lazy in nature whereas the list view constructor
is much more eager in nature and tries to build the list as soon as possible.
Basement during the time we're going to want to use this builder constructor because it's much stronger
from a performance perspective.
 */