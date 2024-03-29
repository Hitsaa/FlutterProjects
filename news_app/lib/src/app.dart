import 'package:flutter/material.dart';
import '../src/screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_details.dart';
import 'blocs/coments_provider.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'News!',
          onGenerateRoute: routes,
        ),
      ),
    );
  }
  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          final storiesBloc = StoriesProvider.of(context);
          storiesBloc.fetchTopIds();
          return NewsList();
        },
      );
    }

    else {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          final commentsBloc = CommentsProvider.of(context);
          final itemId = int.parse(settings.name.replaceFirst('/',''));
          commentsBloc.fetchItemWithComments(itemId);
          return NewsDetail(
            itemId: itemId,
          );
        }
      );
    }
  }
}