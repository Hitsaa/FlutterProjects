import 'package:sqflite/sqflite.dart';    //20.2
import 'package:path_provider/path_provider.dart';  //20.2 path provider module is specifically made to work with mobile devices temporary directories or directories on mobile devices
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';
//import 'repository.dart';   //once we done refactor we will comment down the below import.
import 'refactor_repository.dart';  //20.2

class NewsDbProvider implements Source,Cache{     //20.3
  Database db;

  Future<List<int>> fetchTopIds() {                // this method was not defined earlier. It was defined when we created our 'Source' abstract class.
    return null;
    // this is just a fake implementation.
    /*
    Initially when we did not created abstract class 'Source' in Repository class then we had not defined this method in our NewsDbProvider class.
    But as NewsDbProvider is implementing the Source abstract class so we have to add this fetchTopIds method to complete the concrete implementation of Source class.
    Also we returned null. It means NewsDbProvider has nothing to do with this fetchTopIds class.
     */
  }

/*
So before we can just start writing items directly to a database we have to first make sure that a database
exists on the device and we have to get a connection to that database as well. And so we'll put all that logic directly into the method that we will call in it.
Now typically this initial setup stuff would be better off placed inside of a constructor function.However some of the initial setup that we're going to have to do is going to involve some asynchronous
operations.So reaching out onto the devices physical permanent storage is an asynchronous operation and we are not allowed to put asynchronous code into a constructor function.So instead we're going to replace all of it inside of init function.
*/
  void init() async {       //20.4
    Directory documentsDirectory = await getApplicationDocumentsDirectory();  //by calling function getApplication... , it returns a reference to a folder on our mobile device where we can safely somewhat permanently store different files.
    //it's going to return variable of type directory.So we had imported the module dart.io so that we could get access to this type of directory because that is what getApplication... is going to return.

    final path = join(documentsDirectory.path, "items.db"); //Now the documentsDirectory is just a reference to a directory itself it's just a folder reference. So we then join two strings together documentsDirectory.path and the word items.
    //And so the path variable right here stores the reference to the actual file path where we are going to create our database.
    db = await openDatabase(    //20.4 db is used for cache. openDatabase first looks into db. if any reference to the desired data is there then it will directly fetch the data.
      path, //if the path to the existing data is there then openDatabase first will go to that path. If it's not then it will go to onCreate to create new database and assign path to it.
      version: 1, // version is record for us. if we ever change the schema or the structure of the state base we can increment it.
      onCreate: (Database newDb, int version) { //20.4 When a user installs app for the first time then this onCreate function wil write the reference for the data in newDb variable.
        newDb.execute("""     //20.5-6
          CREATE TABLE Items
            (
              id INTEGER PRIMARY KEY,
              type TEXT,
              by TEXT,
              time INTEGER,
              text TEXT,
              parent INTEGER,
              kids BLOB,
              dead INTEGER,
              deleted INTEGER,
              url TEXT,
              score INTEGER,
              title TEXT,
              descendants INTEGER
            )
        """);   //20.6
      },
    );
  }

  Future<ItemModel> fetchItem(int id) async { //20.7 id is our primary key so we can use it to fetch items from our database.
    final maps = await db.query(    // we have to store key value pairs and so we used Map data structures as List<Map<String,dynamic>>. // we used await keyword to wait fot the operation to complete inside of our function.
      "Items",
      columns: null,    //column that we have to fetch from our table Items say title or id etc. null specifies to fetch entire Item tables.
      where: "id = ?",  //20.7 It's specifying the actual search criteria that we use when we issue any query over to our database.
      whereArgs: [id],  //20.7 So our question mark right here is going to be replaced with the WhereArgs list are specifically the first element within that list.

      /*20.7
      by putting in whereArgs and then a list of the arguments we want to pass on to the query we get the ability to have our sqlite database or more specifically the sqflite package
      automatically scrub or sanitize the different arguments we passed in which is going to avoid any type of potential for a "sql injection" attack on our sql database.
       */
    );

    if(maps.length > 0) {     //20.9 if we found atleast one result from our list of items then we will return ItemModel otherwise return null saying we don't have specified item in ItemModel.
      return ItemModel.fromDb(maps.first); //20.9 The getter defined for the class 'List<Map<String, dynamic>>'.
    }
    return null;
  }

  Future<int> addItem(ItemModel item) {   //20.9 item is an instance of ItemModel
    return db.insert("Items",item.toMap()); //20.10 passing the string of Items that we created for our table.
    /*
    The second argument is a map with values of type string. insert(String table, Map<String, dynamic> values, ...). our item is an instance of ItemModel. by the second
    of insert method accepts the type Map. So to convert that item to Map we made a function toMap in our ItemModel class as Map<String,dynamic> toMap();
     */
  }
}
/*
Unfortunately the sqlite package that we're using does not allow you to create databases on normal computers like PC or Mac
The sqflite packages only works on mobile devices.
 */