import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../resources/refactor_repository.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class CommentsBloc {                //23.12
  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  //Streams getters           //23.13
  Observable<Map<int, Future<ItemModel>>> get itemWithComments => _commentsOutput.stream;

  //Sink Getters
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc(){
    _commentsFetcher.stream.transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  _commentsTransformer() {          //23.13
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
        (cache, int id, index) {
          //recursive fetch
          /*
          //attempt to fetch that very particular item that just came in as an ID.
          It's then going to produce a future because remember this does not instantly fetch the item it returns
          a future and we are putting all those features into our cache.
          */
          cache[id] = _repository.fetchItem(id);
          /*
          I'm going to reference the future that we just put into that map. I'm going to chain onto that future and get a notification of when that future has finished fetching its value.
          When ever this future that we just assign to this map right here resolves with its item model we can chain on this .then function and we can pass in our own function like so.
          So then as soon as this future right here resolves with the item model that it was trying to fetch this inner function right here will be invoked.
          And so this inner function right here is going to be called with the item model that we just fetched.
          Inner function here , is the function inside .then((ItemModel item) { }
           */
          cache[id].then((ItemModel item) {
            item.kids.forEach((kidId) => fetchItemWithComments(kidId));     //fetchItemWithComments is working as sink.
          });
        },
      <int, Future<ItemModel>> {}, //empty cache map.
    );
  }
  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();        //23.13
  }
}