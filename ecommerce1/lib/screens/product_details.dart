import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_new_price;
  final product_detail_old_price;
  final product_detail_picture;
  
  ProductDetails(
  {
    this.product_detail_name,
    this.product_detail_new_price,
    this.product_detail_old_price,
    this.product_detail_picture
}
      );
  
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: Text('ShopApp'),
        actions: <Widget>[
          new IconButton (
              icon: Icon(
                  Icons.search,
                  color: Colors.white),
                  onPressed: () {}),
          new IconButton (
              icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white),
                  onPressed: () {}),
        ],
      ), //AppBar
      
      body: new ListView(
        children: <Widget>[
          new Container(
            height: 300.0,
            //color: Colors.black,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.asset(widget.product_detail_picture),
              ),
              footer: new Container(
                color: Colors.white70,
                child: ListTile(
                  leading: new Text(widget.product_detail_name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                  title: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("\$${widget.product_detail_old_price}",
                        style: TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough),) //we have integer values for price so we are using "$" sign
                      ),
                      Expanded(
                          child: new Text("\$${widget.product_detail_new_price}",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),)
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          //the first buttons
          Row(
            children: <Widget>[

              //the size button
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                  showDialog(context: context, 
                      builder:(context){
                        return new AlertDialog(
                          title: new Text("Size"),
                          content: new Text("Choose the Size"),
                          actions: <Widget>[
                            new MaterialButton(onPressed: () {
                              Navigator.of(context).pop(context); //whenever we click on close then window will close
                            },
                            child: new Text("close"),),
                          ],
                        );
                      });
                },
                color: Colors.white,
                textColor: Colors.grey,
                  elevation: 0.2,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: new Text("Size"),
                    ),

                    Expanded(
                      child: new Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ),
              ),

              //the size button
              Expanded(
                child: MaterialButton(onPressed: () {
                  showDialog(context: context,
                      builder:(context){
                        return new AlertDialog(
                          title: new Text("Color"),
                          content: new Text("Choose the color"),
                          actions: <Widget>[
                            new MaterialButton(onPressed: () {
                              Navigator.of(context).pop(context); //whenever we click on close then window will close
                            },
                              child: new Text("close"),),
                          ],
                        );
                      });
                },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("Color"),
                      ),

                      Expanded(
                        child: new Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ),
              ),

              //the size button
              Expanded(
                child: MaterialButton(onPressed: () {
                  showDialog(context: context,
                      builder:(context){
                        return new AlertDialog(
                          title: new Text("Quantity"),
                          content: new Text("Choose the quantity"),
                          actions: <Widget>[
                            new MaterialButton(onPressed: () {
                              Navigator.of(context).pop(context); //whenever we click on close then window will close
                            },
                              child: new Text("close"),),
                          ],
                        );
                      });
                },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("Qty"),
                      ),

                      Expanded(
                        child: new Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          //the second buttons
          Row(
            children: <Widget>[

              //the size button
              Expanded(
                child: MaterialButton(onPressed: () {},
                  color: Colors.red,
                  textColor: Colors.white,
                  elevation: 0.2,
                  child: new Text("Buy now"),
                ),
              ),

              new IconButton(icon: Icon(Icons.add_shopping_cart, color: Colors.red,), onPressed: () {}),
              new IconButton(icon: Icon(Icons.favorite_border),color: Colors.red, onPressed: () {}),
            ],
          ),
          Divider(color: Colors.black38,),
          new ListTile(
            title: new Text("Porduct details",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            subtitle: new Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",style: TextStyle(color: Colors.black,fontStyle: FontStyle.italic),
            ),
          ),
          Divider(),
    new Row(
    children: <Widget>[
      Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
      child: new Text("Product name",style:TextStyle(color: Colors.grey),
                ),
              ),
      Padding(padding: EdgeInsets.all(5.0),
      child: new Text(widget.product_detail_name),)
            ],
          ),

          new Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text("Product brand",style:TextStyle(color: Colors.grey),
                ),
              ),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text("Brand X"),)
            ],
          ),

          new Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text("Product condition",style:TextStyle(color: Colors.grey),
                ),
              ),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text("New"),)
            ],
          ),
        ],
      ),
    );
  }
}