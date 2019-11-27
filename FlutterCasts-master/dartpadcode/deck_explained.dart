void main() {
  var deck = new Deck();	//instance of class Deck.
	//So that gives us a reference to a new Deck object that has been created inside of our application				
  //here I am calling a function after calling which all the 52 cards in the suite will automatically called.
  deck.removeCard('Diamonds', 'Ace');
  		
	//To invoke shuffle method we call it in main function.
	deck.shuffle();

	print(deck);		//It is passing the reference of class Deck. This reference is then converted to String using toString function
//in Class Deck and Card which prints the cards with suits and ranks.	
}

class Deck {
	//List<Card> cards; 
//below we initialized with empty list. if we do not initialize (as above) with empty list then Cards.add(card) willl give error message.
//It is because in our computer memory cards is not initilized with anything. It means it is initialized with null. so we are trying to 
//do null.add(card) and thus it is giving error. If we initialize it with empty list then it will actually do list.add(card).
  List<Card> cards = [];
  
	//we created a constructor function inside Deck class so that we can declare and retrieve all the 52 cards.
	//every time we call this constructor function we creat a new instance of deck and add it to the cards property.
	
  Deck() {
    var ranks = ['Ace', 'Two', 'Three', 'Four', 'Five'];	//list of ranks
    var suits = ['Diamonds', 'Hearts', 'Clubs', 'Spades'];	//list of suits
    
    for (var suit in suits) {
      for (var rank in ranks) {
        var card = new Card(rank, suit);	//In Card class we defined a constructor function that accepts String arguments rank,suit.
        cards.add(card);			//add function adds cards with rank and suite in the empty list.
      }
    }
  }
  
	//the list of cards are convertd to string using this toString method.
  toString() {
    return cards.toString();	//if this toString method is not used then on console we will see Instance of deck.
//It means when we do print then it actually prints the instance of class Deck. because we have passed a variable/representation 
//of our Deck class that is deck in our print statement above.	  
  }
  
  shuffle() {
    cards.shuffle();
/*
cards.shuffle is a reference to the list that belongs to our instance of the class and then on that list object we're going to call the 
shuffle method which is going to automatically randomize all the elements within that list.
*/
  }

//From the deck of cards if I choose a suit of spades then it should reutrn string of spades in the deck.	
  cardsWithSuit(String suit) {
    return cards.where((card) => card.suit == suit);
/*
To retrieve the card from the particular uit we have to use fpr loop or something like any other loops.BUt dart has some Standard library
for it and we can use a function from that library.
where(bool test(E element) -> iterable<E>. It reuturns a new lazy iterable with all elements that satisfy the predicate test.
lazy terable -> It's kind of like list.

We defined a function without a name and we passed it in to the where method. The method then takes this function and it runs that 
function one time for every element within the cards list.

So every single card within the cards list is taken and it's passed to this function as the first argument. Then inside that function
we have to write some logic that returns a boolean.
True - value is retained.
False - We don't care about this element.

Now we also have to make sure that whatever gets retruned from CardStock where gets returned from our cards with suit function as well.
To do so we have to add retrun keyword befor te function where().
*/
  }
  
  deal(int handSize) {
    var hand = cards.sublist(0, handSize);
    cards = cards.sublist(handSize);
    
    return hand;
  }
  
  removeCard(String suit, String rank) {
    cards.removeWhere((card) => (card.suit == suit) && (card.rank == rank));
  }
}

class Card {
  String suit;
  String rank;
  
  Card(this.rank, this.suit);
  
	//we declared toString method in Deck class then why it is necessary here?
	//it is because using Card constructor we are successfully able to fetch the instances or representations of rank and suit stored in the list. 
	//But we actually couldn't fetch the values from those instances.So they will print instance of card on console.
	//But we want suits and ranks name. For that we have to convert those instances to String using toString() function.
  toString() {
    return '$rank of $suit';	
//this "$" sign here does the string interpolation. so it will look at the rank property and suit property of the card instance and it's going to insert them into this toString.	  
  }
}




