/*So remember any time that we make a block we also make that provider to go along with it and the provider makes our block available at any location
inside of the widget tree.
This bloc will handle showing the story details page which is supposed to show a summany of the story and all the comments associated with it.
 */

import 'package:flutter/material.dart';
//import 'stories_bloc.dart';
import 'refactor_stories_bloc.dart';
//export 'stories_bloc.dart';
export 'refactor_stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  final StoriesBloc bloc;

  StoriesProvider({Key key, Widget child})
      :bloc = StoriesBloc(),
      super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  static StoriesBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(StoriesProvider)
            as StoriesProvider)
        .bloc;

  }

}
