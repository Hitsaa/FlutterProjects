import 'package:english_words/english_words.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class MyApp extends StatelessWidget {
  Widget build(BuildContext build)
  {
    //final wordPair = WordPair.random(); //added in step2. removed in step 3.
    return MaterialApp(
//      title: 'My home page',  //removed in step 4.5
        title: 'Startup Name Generator',
      //On Android: it is used in Recent apps
      //On iOS: it is used in App switcher
//      home: Scaffold( //removed in step 4.5
        home: RandomWords(),  //everything below it removed in step 4.5
//        appBar: AppBar(
 //         title: Text('My material app'),   //this title is displayed in appbar of the app screen
   //     ),
     //   body: Center(
       //   child: Text('Welcome'), //removed in step2.
          // we used child because body is defined as the body below the app bar and text is the part of body so to give it space we used child of body.
          //child: Text(wordPair.asPascalCase),  //removed in step 3
       //   child: RandomWords(),   //added in step 3.
        //),
      //),
    );
  }
}

/*
*Observations
This example creates a Material app. Material is a visual design language that is standard on mobile and the web. Flutter offers a rich set of Material widgets.
The main() method uses arrow (=>) notation. Use arrow notation for one-line functions or methods.
The app extends StatelessWidget which makes the app itself a widget. In Flutter, almost everything is a widget, including alignment, padding, and layout.
The Scaffold widget, from the Material library, provides a default app bar, title, and a body property that holds the widget tree for the home screen. The widget subtree can be quite complex.
A widget’s main job is to provide a build() method that describes how to display the widget in terms of other, lower level widgets.
The body for this example consists of a Center widget containing a Text child widget. The Center widget aligns its widget subtree to the center of the screen.
 */

//Step 2: Use an external package

/*
*In this step, you’ll start using an open-source package named english_words, which contains a few thousand of the most used English words plus some utility functions.
You can find the english_words package, as well as many other open source packages, on pub.dev.
The pubspec file manages the assets and dependencies for a Flutter app. In pubspec.yaml, add english_words (3.1.0 or higher) to the dependencies list:
 */


//Step 3: Add a Stateful widget
/*
Stateless widgets are immutable, meaning that their properties can’t change—all values are final.
Stateful widgets maintain state that might change during the lifetime of the widget. Implementing a stateful widget requires at
least two classes:
1) a StatefulWidget class that creates an instance of 2) a State class.
The StatefulWidget class is, itself, immutable, but the "State class persists over the lifetime of the widget".
 */

//In this step, you’ll add a stateful widget, RandomWords, which creates its State class, RandomWordsState. You’ll then use
// RandomWords as a child inside the existing MyApp stateless widget.

class RandomWordsState extends State<RandomWords>{
  //Todo
  //step 4.1
/*
Add a _suggestions list to the RandomWordsState class for saving suggested word pairings. Also, add a _biggerFont variable for making the font size larger.
 */

  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  //step 4.2
  /*
  Add a _buildSuggestions() function to the RandomWordsState class:
   */

  Widget _buildSuggestions(){
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder /*1*/: (context, i) {
          if(i.isOdd) return Divider(); /*2*/
          final index = i ~/2;    /*3*/
          if(index >= _suggestions.length) {
            _suggestions.addAll(prefix0.generateWordPairs().take(10));  /*4*/
          }
        });
  }

  //step 4.3
  /*
Add a _buildRow() function to RandomWordsState:
   */
  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }

  //step 4.4
  /*
  In the RandomWordsState class, update the build() method to use _buildSuggestions(), rather than directly calling the word generation library. (Scaffold implements the basic Material Design visual layout.)
   */
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
}

/*
Notice the declaration State<RandomWords>. This indicates that we’re using the generic State class specialized for use with
RandomWords. Most of the app’s logic and state resides here—it maintains the state for the RandomWords widget. This class saves
the generated word pairs, which grows infinitely as the user scrolls, and favorite word pairs (in part 2), as the user adds or
removes them from the list by toggling the heart icon.
RandomWordsState depends on the RandomWords class. You’ll add that next.
 */

/*
After adding the state class, the IDE complains that the class is missing a build method. Next, you’ll add a basic build method
that generates the word pairs by moving the word generation code from MyApp to RandomWordsState.
 */
//The RandomWords widget does little else beside creating its State class:

//Step 4: Create an infinite scrolling ListView
/*
In this step, you’ll expand RandomWordsState to generate and display a list of word pairings. As the user scrolls, the list
displayed in a ListView widget, grows infinitely. ListView’s builder factory constructor allows you to build a list view lazily,
on demand.
1 .Add a _suggestions list to the RandomWordsState class for saving suggested word pairings. Also, add a _biggerFont variable for
making the font size larger.
 */

class RandomWords extends StatefulWidget{
  RandomWordsState createState() => RandomWordsState();

}

/* explanation of state 4.2
/*1*/ The itemBuilder callback is called once per suggested word pairing, and places each suggestion into a ListTile row. For even rows, the function adds a ListTile row for
      the word pairing. For odd rows, the function adds a Divider widget to visually separate the entries. Note that the divider might be difficult to see on smaller devices.
/*2*/ Add a one-pixel-high divider widget before each row in the ListView.
/*3*/The expression i ~/ 2 divides i by 2 and returns an integer result. For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2. This calculates the actual number of word pairings
      in the ListView, minus the divider widgets.
/*4*/If you’ve reached the end of the available word pairings, then generate 10 more and add them to the suggestions list.
      The _buildSuggestions() function calls _buildRow() once per word pair. This function displays each new pair in a ListTile, which allows you to make the rows more attractive
      in the next step.
 */

/*
we created a class RandomWordsState that extends State<RandomWords>. Here RandomWords is a class whose state is stored in the
object of State class. class RandomWords extends StatefulWidget it means this class will contain some state and its state is
mutable. so state of object that was created in RandomWordsState class is actually created automatically on calling createState()
method. so observe that createState() method is returning RandomWordsState() class to the RandomWords widget.
 */


