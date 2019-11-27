import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';

class Refresh extends StatelessWidget {
  final Widget child;
  Refresh({this.child});

  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return RefreshIndicator(
      child: child,
      onRefresh: () async{    //22.42
        //return bloc.clearCache();  //instead of return we can do async and await method also to fulfill our purpose.
        await bloc.clearCache();
        await bloc.fetchTopIds();   //22.42
      },

    );
  }
}