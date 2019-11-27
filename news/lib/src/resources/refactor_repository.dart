import 'dart:async';
import 'news_api_provider.dart';
import '../models/item_model.dart';
//import 'news_db_provider.dart';   //once done with refactor remove this comment and do comment of below import.
import 'refactore_news_db_provider.dart';
class Repository {      //21.8
  /*
  NewsDbProvider dbProvider = NewsDbProvider();   //right now we have got the specific slot of this dbProvider and apiProvider. if we try to add another provider say MysteryProvider
  NewsApiProvider apiProvider = NewsApiProvider();  // and try to invoke fetchItem then we would generate an error as fetchItem is specified to invoke through dbProvider.
  MysteryProvider mystrery = MysteryProvider();   // to solve this problem we are making a list of Source providers and cache providers.

  Now suppose we want to invoke fetchItem . from this list of Sources each of the providers will be inspected one by one and which so ever have any invoke method for fetchItem()
  will automatically be used.
   */
  List<Source> sources = <Source>[        //21.9
    //NewsDbProvider(),
    newsDbProvider,       //21.12
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[     //21.9
    //NewsDbProvider(),
    newsDbProvider,         //21.12
  ];

  /*21.9 we are creating two instances of news_db_provider and each of those are accessing the same database. { final path = join(documentsDirectory.path, "items.db"); }
we are creating a connection of the items to the Db database.So turns out that sql lite really doesn't like it when you try to open up the same database multiple times.
So just to solve that issue rather than attempting to create multiple instances of the news_db_provider, we're going to create a single instance of this class inside
news_db_provider file and then use that single instance in both the list of sources and caches right here just to avoid accidentally opening the thing up multiple times.
Inside our file news_db_provider at the bottom we are creating an instance variable for NewsDbProvider.
 21.9 */


  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();        //21.13
    /*
    // as we call sources[1] means we are passing NewsApiProvider instance through sources defined as an instance of list of Source. This is how it becomes easy for us to invoke
    fetchTopIds only from NewsApiProvider class. As we know that we did a fake implementation of fetchTopIds in our NewsDbProvider class also, so it will not invoke that method.
     */
  }

  Future<ItemModel> fetchItem(int id) async {       //21.10
    ItemModel item;
    //Source source;
    var source;     //22.31

    for (source in sources) {
      item = await source.fetchItem(id); //So if a given source has never seen this item before, fetchItem will return NULL.
      //So item is either going to be the value Null or the ItemModel that We are looking for.

      if (item != null) {
        break;
      }
    }               //21.10
/*21.10
if we find an item that we've never seen before we're going to go fetch it from the API and then eventually back it up to our news_db_provider which we are now referring to as
cache inside of our application. So after we find the item will then iterate through all of our different caches so save our cache in caches and we will addItem on each one of those cache.
21.10  */
    for(var cache in caches) {        //21.10
      if(cache != source) {     //equality warning error given here. to remove that error we have 3 methods.
        cache.addItem(item);    //1.replace type of source from Source to var as we did.2. if(cache as source != source). 3.if(cache != source as cache).
      }

    }
    return item;
  }

  clearCache() async{       //22.41;
    for(var cache in caches) {
      await cache.clear();
    }
  }
}

abstract class Source {           //20.7-8
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {            //20.7-8
  Future<int> addItem(ItemModel item);
  Future<int> clear();      //22.41
}

