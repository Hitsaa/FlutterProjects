import 'package:flutter/material.dart';
import '../src/screens/news_list.dart';
import 'blocs/stories_provider.dart';   //22.9
import 'screens/news_details.dart';     //23.4
import 'blocs/coments_provider.dart';       //23.14

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(   //23.14
        child: MaterialApp(
          title: 'News!',
          //home: NewsList(),
          onGenerateRoute: routes,      //23.14
        ),
      ),
    );

    /*return StoriesProvider(   //22.9, comment in 23.14
      child: MaterialApp(
        title: 'News!',
        //home: NewsList(),
        onGenerateRoute: routes,      //23.6
        ),
        );
        */

/*        onGenerateRoute: (RouteSettings settings) {     //23.4, 23.6
          return MaterialPageRoute(
            builder: (BuildContext context) {
              return NewsList();
            }
          );
        },*/


    /*
    return MaterialApp(
      title: 'News!',
      home: NewsList(),
    );
    */

  }

  Route routes(RouteSettings settings) {    //23.6
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          final storiesBloc = StoriesProvider.of(context);      //23.34
          storiesBloc.fetchTopIds();                        //23.34
          return NewsList();
        },
      );
    }
    else {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          //23.6 extract the item id from settings.name and pass into NewsDetail
          // A fantastic loacation to do some initialization or data fetching for NewsDetail.
          final commentsBloc = CommentsProvider.of(context);      //23.14
          final itemId = int.parse(settings.name.replaceFirst('/',''));    //23.8

          commentsBloc.fetchItemWithComments(itemId);   //23.14

          return NewsDetail(
            itemId: itemId,
          );          //23.6
        }
      );
    }
  }
}