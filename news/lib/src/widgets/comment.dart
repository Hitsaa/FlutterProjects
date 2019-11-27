//23.22

import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import 'loading_container.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;                            //23.29

  Comment({this.itemId, this.itemMap, this.depth});         //23.23, 23.29
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel>snapshot){
        if(!snapshot.hasData){
          //return Text('Still loading comment');   //23.23   commented in 23.32
          return LoadingContainer();                //23.32
        }

        final item = snapshot.data;         //23.26
        final children = <Widget>[
          //Text(snapshot.data.text),     //23.23   commented inn 23.26
          ListTile(                           //23.26
            //title: Text(item.text),           //23.26,        commented in 23.31
            title: buildText(item),                 //23.31
            subtitle: item.by == "" ? Text("Deleted") : Text(item.by),        //23.28
            contentPadding: EdgeInsets.only (       //22.30
              right: 16.0,
              left: (depth + 1) * 16.0,             //22.30
            ),
          ),
          Divider(),                //23.26
        ];
        item.kids.forEach((kidId) {      //23.25
          children.add(Comment(
            itemId: kidId,
            itemMap: itemMap,                 //23.25, 23.29
            depth: depth + 1,
          ),
          );
        }
        );
        /*return Column(        //23.25
         children: [
            Text(snapshot.data.text),       //23.25  also commented in 23.25

          ],
          );*/
          return Column(
          children: children,
        );

        //return Text(snapshot.data.text);    //23.23   commented in 23.25
      },
    );
  }

  buildText(ItemModel item) {
    final text = item.text
        .replaceAll('&#x27;', "'")
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p', '');
    return Text(text);
  }
}