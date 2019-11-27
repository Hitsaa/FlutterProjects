import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class CommentsBloc {
  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  //Streams getters
  Observable<Map<int, Future<ItemModel>>> get itemWithComments => _commentsOutput.stream;

  //Sink Getters
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc(){
    _commentsFetcher.stream.transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
        (cache, int id, index) {
          //recursive fetch

          cache[id] = _repository.fetchItem(id);

          cache[id].then((ItemModel item) {
            item.kids.forEach((kidId) => fetchItemWithComments(kidId));
          });
        },
      <int, Future<ItemModel>> {}, //empty cache map.
    );
  }
  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}