
import 'package:flutter/material.dart';
//import 'dart:async';
import '../blocs/stories_provider.dart';    //22.9
//import '../blocs/stories_bloc.dart';    //we don't need this import as we imported it in stories_provider file and exported at the same time.
import '../widgets/news_list_tile.dart';
import '../widgets/refresh.dart';

class NewsList extends StatelessWidget {

  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);   //context gives us essentially a reference of our hierarchy where the widget tree and we're going to crawl up the tree until we find the instance of the story's provider and then that returns the reference to the block that is tied to these stories.
/*23.34
    //This is Bad!!!!!! Don;t do this.  22.10
    // Temporary!
    bloc.fetchTopIds();   //22.10
*/
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      //body: Text('Show some news!!'),
      //body: buildList(),
      body: buildList(bloc),
    );
  }

/*
  Widget buildList() {
    return ListView.builder(
      itemCount: 1000,    // fetch 1000 items but not simultaneously.
      itemBuilder: (context, int index) { //itemBuilder function gets called with context. Index is an integer that reflects the current row that the list view is trying to build.
/*
So inside of this item builder function right here is where we are going to build some type of widget
that is going to represent one individual line item that is going to be rendered on the screen. So for us, inside of this item builder is where we're going to want to kind of simulate
fetching some data from our repository and then only when that future that we get back from the repository resolves with our item model.
 */

 /*
 The Future that we would want to stick in here would kind of represent the item that we're tying to fetch. But as we are just trying sample code here so we will define fake function called GetFuture.
 We're going to create a future that starts off in the pending state and then after two seconds it will go to the fulfilled state so inside of your I'm going to return future.delayed.
 So we're now providing a future that's going to resolve after some seconds to future builder.
 So if the snapshot has data which indicates that the future has been successfully resolved I'm going to shows some text on the screen that says I'm visible and I'll print out the index of this item.
  */
       return FutureBuilder(
         future: getFuture(),
         builder: (context, snapshot) {
           return Container(
             height: 80.0,
             child: snapshot.hasData
                 ? Text('I m visible $index')
                 : Text('I havent fetced data yet $index');,
           );
           /*return snapshot.hasData
               ? Text('I m visible $index')
               : Text('I havent fetced data yet $index'); */
         },
       );
      },
    );
  }

  getFuture() {
    return Future.delayed(
      Duration(seconds: 2),
        () => 'hi',
    );
  }

*/

  Widget buildList(StoriesBloc bloc) {  //22.10
    return StreamBuilder(
      stream: bloc.topIds,
      //builder: (context, snapshot) { //22.10
      builder: (context, AsyncSnapshot<List<int>> snapshot) { //22.11 let the dart knows that the data we are fetching is of type List of integers.
        if (!snapshot.hasData) {
          return Center(                            //22.12
            child: CircularProgressIndicator(),
          );
          //return Text('Still wai ting on Ids');   //22.10
          //return CircularProgressIndicator();      //22.12
        }
        return Refresh(     //22.40
          child: ListView.builder(    //22.40
            itemCount: snapshot.data.length,
            itemBuilder: (context, int index) {
              bloc.fetchItem(snapshot.data[index]);   //22.40

              return NewsListTile(        //22.24
                itemId: snapshot.data[index],
              );
            },
          ),
        );

        /* 22.40
        //return ListView.builder(    //22.10
        //            itemCount: snapshot.data.length,
        //            itemBuilder: (context, int index) {
        //              //return Text(snapshot.data[index]);    //22.10 we're trying to show an integer inside this text note, the text node does not expect to be called with an integer. It expects to always receive a string.
        //              bloc.fetchItem(snapshot.data[index]);   //22.21
        //
        //              //return Text('${snapshot.data[index]}');   //22.11 we converted the integer to string by placing single quotes and $ sign.
        //              return NewsListTile(        //22.24
        //                  itemId: snapshot.data[index],
        //              );
        //            },
        //        );
        22.40 */
      },
    );
  }
}