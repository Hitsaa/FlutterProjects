//23.4
import 'package:flutter/material.dart';
import '../blocs/coments_provider.dart';      //23.16
import 'dart:async';
import '../models/item_model.dart';
import '../widgets/comment.dart';

class NewsDetail extends StatelessWidget {
  final itemId;               //23.8
  NewsDetail({this.itemId});      //23.8

  Widget build(BuildContext context) {
    //return Text('i am a news detail');    //23.4
    final bloc = CommentsProvider.of(context);      //23.16

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      //body: Text('I am a details screen'),    //23.8
      //body: Text('$itemId'),        //23.8
      body: buildBody(bloc),    //23.16
    );
  }

  Widget buildBody(CommentsBloc bloc) {     //23.17
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading');
        }
        final itemFuture = snapshot.data[itemId];     //23.17

        return FutureBuilder(
          future: itemFuture,
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if(!itemSnapshot.hasData) {
              return Text('Loading');               //23.17
            }

            //return Text(itemSnapshot.data.title);       //23.17   comment in 23.17

            //return buildTitle(itemSnapshot.data);       //23.18  comment in 23.21
            return buildList(itemSnapshot.data, snapshot.data);
          },
        );
      },
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {       //23.24
    final children = <Widget> [];           //23.24
    children.add(buildTitle(item));                     //23.24
    final commentsList = item.kids.map((kidId) {
      return Comment(itemId: kidId, itemMap: itemMap, depth: 0,);                          //23.24, 23.29
  }
  ).toList();
    children.addAll(commentsList);        //23.24
/* commented in 23.24
    return ListView(          //23.22
    children: <Widget>[
      buildTitle(item),       //23.22
    ],
    );
 */
  return ListView(          //23.24
    children: children,
  );
  }

  Widget buildTitle(ItemModel item) {             //23.18
    return Container(
      margin: EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child: Text(
          item.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,          //23.18
          ),
      ),
    );
  }                                               //23.18
}