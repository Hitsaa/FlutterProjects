import 'package:flutter/material.dart';
import 'package:http/http.dart' show get; //We use this to make a request to some outside url so we can call the get function with some url to make the request.
import 'widgets/images_list.dart';
import 'models/image_model.dart';
import 'dart:convert';
/*
Our mobile device is going to make a HTTP request over the internet to this outside API server.It's going to request some amount of data.
The API server will see the request and respond with the data.Now what this diagram right here doesn't show is the fact that
it might take some very substantial amount of time for this request to be completed. And that's what that future is meant to help with.
Futures are meant to help with code that will take some amount of time to execute or any event that
might take some amount of time to execute to get a better handle on what a future actually is and how we interact with it.
 */

class App extends StatefulWidget {

  createState() {
    return AppState();
  }
}

class AppState extends State<App>  //State is a generic class in flutter. State<T extends StatefulWidget>
{
  /*
  State is information that (1) can be read synchronously when the widget is built and (2) might change during the lifetime of the
  widget. It is the responsibility of the widget implementer to ensure that the State is promptly notified when such state changes,
  using State.setState.
   */
  int counter = 0;
  /*
  Our App State widget is now storing every single image inside this image list.
   */
  List<ImageModel> images = [];
/*
Remember every time the user presses this button we're going to fetch one additional image model and we want to render out a list of all those on the screen to the user.
So I think that we should create a list instance variable tied to our App State widget. It will be a list data type and every time we create a new
image model we will add it to that list.
*/

void fetchImage() async {
    counter++;
    var response = await get('https://jsonplaceholder.typicode.com/photos/$counter');
    var imageModel = ImageModel.fromJson(json.decode(response.body));
/*
Now one thing I want to point out here is is that this response variable is not the actual Json
data. the response variable is an object that tells us a little bit about the entire response that came
back from that API so it contains status codes headers a lot of information about the actual request
or the response that came back from the request that based on Json data that we actually care about is nested
inside of that response object.
So now that we've at least got something that contains the data json data we care about we can now take
that Json we can decode it and then we can create a new image model instance from it.
We want to take it that Jason out of this response object and construct a new image modeled with it.
So I'm going to call the named constructor from Jason and I'm going to pass in that Jason from the response
object which is available on response body.
 */

/*
every time that we are adding a new record to the image model we absolutely expect to see our App State widget tries to re render itself
and probably display the new image on the screen.
So in order to make that happen I'm going to wrap the images.add(imageModel) in my setState() function;
 */

  setState(() {
    images.add(imageModel);
  });
  }

  Widget build(BuildContext context)
  {
    return MaterialApp (
      home: Scaffold(
              body: ImageList(images),  //counter was defined here and removing that placed ImageList constructor .11.13
/*
for the body parameter right here I will create a instance of image list now any time that we create our copy of image list
(above in AppState class) and try to show it on the screen the image list is definitely going to need that list of all the image
models that we have fetched so far. So we need to take this list of images(defined in AppState class) and pass it to the image list widget.
To do so we are going to go back to the ImageList constructor (just above these comments) and pass images into it
*/
              floatingActionButton : FloatingActionButton(
        /*
        So we probably want to make the request only when the user presses on that floating action button.
        When a user presses on that button that means it's now time to fetch one additional image from that Json API.
         */
        //child: Text('+'),
                  child : Icon(Icons.add),
        /*onPressed : () {
          ()setState(() {
            counter+=1;
          });
        },*/
                  onPressed: fetchImage,
      ),
      appBar: AppBar(
        title: Text('Let\'s see images'),
      ),
      )
    );
  }
}