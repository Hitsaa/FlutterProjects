//22.28
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
export '../models/item_model.dart';
import '../resources/refactor_repository.dart';
import 'dart:async';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();    //22.28
  final _itemsFetcher = PublishSubject<int>();


  //getters To Streams
  Observable<List<int>> get topIds => _topIds.stream;
  Observable<Map<int,Future<ItemModel>>> get items => _itemsOutput.stream;    //22.28

  Function(int) get fetchItem => _itemsFetcher.sink.add;

  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
    /*
    It takes a source of events or essentially a stream right here so this is a stream. It takes every output event from that stream and it automatically forwards it on to some target destination.
    So everything that comes out of items fetcher and its transformer automatically gets sent on to the items output.
     22.28 */
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  clearCache() {
    return _repository.clearCache();
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
          (Map<int, Future<ItemModel>> cache, int id, index) {
        print(index);
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _topIds.close();
    _itemsFetcher.close();
    _itemsOutput.close();
  }
}