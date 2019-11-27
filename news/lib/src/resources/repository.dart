//20.11
import 'dart:async';
import 'news_api_provider.dart';
//import 'news_db_provider.dart';
import 'refactore_news_db_provider.dart';
import '../models/item_model.dart';

class Repository {      //20.11
  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  Future<List<int>> fetchTopIds() {     //20.11
    return apiProvider.fetchTopIds();   //20.12
  }

  Future<ItemModel> fetchItem(int id) async {   //20.12
    var item = await dbProvider.fetchItem(id);   //20.12 looking if our requested item is already there in database or not.since this is asynchronous operation so we have to mark await keyword.
    //now we will see whatever we have fetched, whether it's an itemModel or Null.
    if(item != null) {
      return item;  // if we find item in our dbprovider then we return that item.
    }
    // if we don't find the requested item then we will say our news_api_provider to go and get it from Hacker News API.
    item = await apiProvider.fetchItem(id); //20.12 item keyword is initialized with var. it is so becoz it's value is changing above and here.
    /*await*/ dbProvider.addItem(item); //20.12 once we fetch the item we add that item in our dbprovider for our future use.await keyword as it is an asynchronous operation.(optional)
    /*
    But in reality when we are looking for a record from this fetch item function right here we're only concerned with getting back our record.
     And so taking that record taking that item and stuffing back into the database is not something that we really need to wait to occur or finish up before we return our item from this function.
     So even though we can mark this thing with the await keyword we're going to not put await on there because  we do not care about waiting for this item to be added to our database before progressing.
     */
    return item; //returning the item that we fetched.
  }
}

//These abstract classes are added as part of refactoring of repository.

abstract class Source {     //21.7-8
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {  //21.7-8
  Future<int> addItem(ItemModel item);
}

//So I want the repository to work with any arbitrary number of sources or caches that we load up.