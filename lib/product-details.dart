import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dunya/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class ProductDetails extends StatefulWidget {
 var product;
  ProductDetails(this.product);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}
class _ProductDetailsState extends State<ProductDetails> {
  Future addToCart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("user-cart");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget.product["name"],
      "price": widget.product["price"],
      "images": widget.product["img"],
      "qty": widget.product["qty"],

    }).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=> fetchData ('user-cart'))));
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      extendBodyBehindAppBar: true,
     // backgroundColor: Colors.orange,
          backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text('Product Details',style: GoogleFonts.sansita(
            fontSize:30,
            color:Colors.white,
          )),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.blueGrey[800],
                  size: 20,
                )),
          ),
        ),
      ),

      body: Container(
        height: double.infinity,
        width: double.infinity,
        //color: Colors.green,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage
                  ('assets/b1.jpg'),

                fit: BoxFit.fill
            )
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start ,
              children: [
              //  Image.asset(widget.product['img'],),
                Center(
                  child: Container(
                      height: 250,
                      width: 200,
                      child: Image.network(widget.product['img'],fit: BoxFit.contain,)),
                ),
               SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('Description',style: GoogleFonts.acme(
                    fontSize:40,
                    color:Colors.white,
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(widget.product['decs'],
                      style: GoogleFonts.acme(
                        fontSize:20,
                        color:Colors.white,
                      )
                  ),
                ),
              SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('Price',style: GoogleFonts.acme(
                    fontSize:40,
                    color:Colors.white,
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(widget.product['price'],
                      style: GoogleFonts.acme(
                        fontSize:20,
                        color:Colors.white,
                      )
                  ),
                ),
                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: Size(400, 45)
                      ),
                      onPressed: (){
                        addToCart();

                      }, child: Text('Add To Cart',
                      style: GoogleFonts.acme(
                        fontSize:30,
                        color:Colors.blueGrey[800],
                      )

                  )),
                )

              ],
            ),
          ),
        ),
      )

    );
  }
}
