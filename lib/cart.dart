
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
Widget fetchData (String collectionName){
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection(collectionName)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items")
        .snapshots(),
    builder:
        (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Center(
          child: Text("Something is wrong"),
        );
      }

      return Scaffold(
        backgroundColor: Colors.white,
        appBar:AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('Cart',style: GoogleFonts.sansita(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black,
          ),),
          centerTitle: true,

        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Expanded(
              child: Container(
                child:
                ListView.builder(
                    itemCount:
                    snapshot.data == null ? 0 : snapshot.data!.docs.length,
                    itemBuilder: (_, index) {
                      DocumentSnapshot _documentSnapshot =
                      snapshot.data!.docs[index];
                      return
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: Colors.blueGrey,
                                width: 2,
                              ),
                            ),
                            child: ListTile(
                              title: SizedBox(
                                height:175,
                                child: Row(
                                  children: [
                                    Container(
                                        height:300,
                                        width:150,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        padding: EdgeInsets.only(left: 10,right: 10),
                                        child:Image.network(_documentSnapshot['images'],fit:BoxFit.contain)
                                    ),

                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 50,),
                                        Text(_documentSnapshot['name'], style: GoogleFonts.sansita(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black
                                        ),),
                                        SizedBox(height: 6,),
                                        Container(
                                          height: 40,
                                          width: 90,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Center(
                                            child:
                                            Text(
                                                "\$ ${_documentSnapshot['price']}",
                                                style: GoogleFonts.sansita(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white
                                                )
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10),
                                              child: Icon(Icons.add),
                                            ),
                                            SizedBox(width: 10,),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10),
                                              child: Text('0'),
                                            ),
                                            SizedBox(width: 10,),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 5
                                              ),
                                              child: Icon(Icons.minimize_outlined,),
                                            )
                                          ],
                                        )




                                      ],
                                    ),


                                  ],

                                ),

                              ),
                              trailing: IconButton(
                                onPressed: (){
                                  FirebaseFirestore.instance.collection('user-cart').doc(FirebaseAuth.instance.currentUser!.email).collection('items').doc(_documentSnapshot.id).delete();
                                },
                                icon: Icon(Icons.delete,size: 40,color: Colors.black,),
                              ),

                            ),
                          ),
                        );

                    }),

              ),


            ),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('Total :',style: GoogleFonts.sansita(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey
                  ),),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 140),
                  child: Container(
                    height: 40,
                    width: 70,
                    color: Colors.grey,
                    child: Center(child: Text('98.00')),
                  ),
                )
              ],
            )


          ],
        ),
      );
    },
  );
}










