import 'package:http/http.dart' show Client;      //18.7
import 'dart:convert';
import '../models/item_model.dart';
import 'dart:async';
//import 'repository.dart';   //once we done refactor we will comment down the below import.
import 'refactor_repository.dart';

final _root = 'https://hacker-news.firebaseio.com/v0';      //18.8

//18.7
 class NewsApiProvider implements Source {    //18.7 once we have declared the Source abstract class in our Repository class we can implement that in our NewsApiProvider class.
   Client client = Client();
   /*
   Any time that we have a function with async you can essentially imagine that we've got whatever you might think the return type is going to be like in this case we are pretty
   sure that we're going to return a list of integers right here. But in reality there's kind of an intermediate return value that takes our data and wraps it inside of it.
   Future specifically because we're using the async syntax inside of here in order to confirm that we have to wrap this return type with a future like so.
    */
   Future<List<int>> fetchTopIds() async {
     final response = await client.get('$_root/topstories.json');
     final ids = json.decode(response.body);    //18.8
     //return ids;              //18.8
     return ids.cast<int>();    //20.14 we are telling dart that we are returning a list of ids. see List<E> class in dart api documentation.
   }

   Future<ItemModel> fetchItem(int id) async {
     final response = await client.get('$_root/item/$id.json');
     final parsedJson = json.decode(response.body);

     return ItemModel.fromJson(parsedJson);     //18.8
   }
 }