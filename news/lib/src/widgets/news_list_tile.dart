//22.21
/*
this file is going to eventually need to know what a item model is because it's going to want to access an item model to pull off the title properties and whatnot.
this file is going to need to know about what a block is because we're going to eventually want to access our block inside this file to pull the stream out and connect it to our stream builder.
//this is the widget that is responsible for eventually resolving and receiving an item model and then showing that individual title tile on the screen.
 22.21*/

import 'dart:async';
import 'package:flutter/material.dart';
//import '../models/item_model.dart';     //exported in stories_bloc.dart file
import '../blocs/stories_provider.dart';
import '../widgets/loading_container.dart';

/*22.21
This class has to know which ID it is responsible for looking for. So anytime list view makes a new instance of one of these widgets we're putting together the list view
that has to tell it hey you are responsible for showing item with ID 1 or ID 2 or id 3.
 22.21 */

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});  //22.21

  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context); //22.21

    return StreamBuilder( //22.22
      stream: bloc.items,
      builder: (BuildContext context, AsyncSnapshot<Map<int,Future<ItemModel>>>snapshot) {        //AsyncSnapshot<Map<int,Future<ItemModel>>> snapshot.
        //22.22 this snapshot value right here wraps up whatever information is coming from our stream.
        //snapshot is going to be our map in that map is going to be an integer with the future and the item model.
        if(!snapshot.hasData) {
          //return Text('Stream still loading');
          return LoadingContainer();        //22.37
        }

        return FutureBuilder(             //22.23
            future: snapshot.data[itemId],
            builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
              if(!itemSnapshot.hasData) {
                //return Text('Still loading item $itemId');
                return LoadingContainer();      //22..37
              }

              //return Text(itemSnapshot.data.title);   //22.32 So we need to take this itemsnapshot.data property and we need to turn it into a widget that's going to produce all the tile information.
              return buildTile(context,itemSnapshot.data);   //22.32  , 23.4
            },
        );
      },
    );
  }

  //22.32 making a helper method for creating tiles for the stories
/*
  Widget buildTile(ItemModel item) {
    return ListTile(     //22.32 docs.flutter.io
    title: Text(item.title),
      subtitle: Text('${item.score} points'),
      trailing: Column(       //22.33
        /*
        So remember on that trailing property we want to have the comments icon and the number of comments listed
directly underneath that is a quick reminder to get the number of comments on our item model class.
We want to look at that descendants property.So the descendants right here is the number of comments that a particular story has.
         22.33*/
        children: <Widget>[
          Icon(Icons.comment),
          Text('${item.descendants}'),
        ],
      ),
    );
  }
  */
//22.34

  Widget buildTile(BuildContext context, ItemModel item) {
    return Column(
    children: [     //22.34
    ListTile(     //22.34
    onTap: () {
      //print('${item.id} was tapped!!!');  //23.5
      Navigator.pushNamed(context, '/${item.id}');
    },
    title: Text(item.title),
    subtitle: Text('${item.score} points'),
    trailing: Column(       //22.33
    children: <Widget>[
    Icon(Icons.comment),
    Text('${item.descendants}'),
            ],
          ),
        ),
      Divider(
        height: 8.0,
      ),        //22.34
      ],
    );
  }
}