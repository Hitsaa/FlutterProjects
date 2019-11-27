/*
Stories bloc is going to manage top news listing. It's going to fetch the top news IDs and then show a list of all them on the screen.
 */
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/refactor_repository.dart';
import 'dart:async';

/*
So here is our block right here inside of a block we usually create a stream controller a stream controller gives us both a sink and a stream.
The sync gives us the ability to kind of put some information into the stream so we cannot add information to the stream directly.
We usually make the sync right here accessible through a get or on our class or our block right here. So that kind of exposes the sink to the outside world.
So then anytime we call that sink we get the function back which allows us to add in some information they'll be sort of redirected over to our stream then our stream is going to do some amount of processing
and make all the information coming out of it available to the outside world where it can be consumed by widgets inside of our application or more specifically by those stream builder widgets.
 */
class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();  //Because this is going to work with a list of TopIds I will entertain type as a list of integers.
  final _items = BehaviorSubject<int>();   //22.18 stream controllers are replaced by BehaviorSubject in rx dart library  22.18

/* 22.18
BehaviorSubject is a special stream controller.It is special because any time something new listens to our stream, the behavior subject will automatically emit the most recent data event. 22.18
We also made use of the published subject for the top ids. The only special thing about this subject it is the normal same thing as a stream controller.
The only difference is that it's stream property is an instance of an observable rather than a stream. And remember a observable is a stream.
 */

/*
So if we now get access to our repository and attempt to fetch that list of top IDs we can take that list of top IDs dumped them into the sink and the stream controller will automatically direct that list
of integers out to be consumed by different widgets inside of our application.
 */

  Observable<Map<int, Future<ItemModel>>> items; //22.20 This is the instance variable that's going to hold a reference to the transform streamed stream that

  //getters To Streams
  Observable<List<int>> get topIds => _topIds.stream;

  //22.19 Bad Approach. I'll comment below code at line 53.

  //So here's why!!! every time a widget accesses this item Skidder this line of code right here is going to be invoked.
  //And without a doubt we are going to have many many widgets inside of our application that are trying to access this getter below
  // because remember for every one of these widgets(StreamBuilder1,2,3) so we want to have showing an individual item model,
  //They're all going to have stream builders that want to watch that stream.So every time one does to invoke this line of code
  // right here is invoked. Inside that line of code, We've run items transformer so items transformer right here is executed And every time it runs.
  /* 22.19
  So for every separate widget we create a new instance of scanned stream transformer and every instance gets its own separate cache.
  So that's the problem.
  The problem is that every separate widget that tries to access this getter will run this code and every separate one is going to gets own individual
  Cache object that is not shared with any other widgets which is without a doubt not ideal.
  All it means is that we need to make sure that we only try to apply this transformer right here exactly one time to our stream.
  So rather than setting up a Getter for exposing our stream to the outside world we're going take a slightly
  we cannot use a getter with our new items stream controller right here because remember we want to make sure that we only apply this item's transformer exactly one time
  and that would not be the case if we made use of it later.
   */
  //get items => _items.stream.transform(_itemsTransformer()); 22.19

  //Getters to Sinks 22.18
  Function(int) get fetchItem => _items.sink.add;

  //22.20
  StoriesBloc() {
    items = _items.stream.transform(_itemsTransformer());
  }
  /*22.20
  Now one gotcha.
  When we call transform on a stream it does not modify the original stream. So when we call transform on this thing right here this stream it does not get modified.
  Instead it returns a new stream. So a new stream is returned from above line of code right here and that is the stream that we want to expose to the outside world.
  So we need to somehow take the stream that is produced by above line of code and make sure that everyone in the outside world can get access to it.
   */

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

//22.16 this function right here this function will be invoked every single time a new element comes across our stream. 22.16
  _itemsTransformer() {
    return ScanStreamTransformer(
        (Map<int, Future<ItemModel>> cache, int id, index) {        //22.16 index is the number of times that our scan stream transformer has been invoked. but it's not important so it can be replaced by _ .
          print(index);       //22.24
/*22.16
we need to take this ID we need to turn it into a future that resolves with an item model and then we need to add all that stuff to the cache and then return the Cache object because
whatever we return from this function is what gets carried over to the next time this function is invoked.
 */
        cache[id] = _repository.fetchItem(id);    //22.17 We are passing the ID that this transformer just received 22.17
        return cache;
//the return statement is very critical because whatever gets returned from this function remember, that's what gets pumped in to this cache argument the next time the function is invoked.
/*
So all this thing does it takes an id, it fetches the appropriate item, it adds both the ID and that item to this cache object.
So now our stream which before was receiving this ID as an integer, It's now going to be emitting this big gigantic cache map and that's what's going to show up inside
of each of our stream builders that are supposed to represent an individual item.
 */
        },
        <int, Future<ItemModel>>{},   //creating empty cache map
    );
  }

  dispose() {
    _topIds.close();
    _items.close();
  }
}