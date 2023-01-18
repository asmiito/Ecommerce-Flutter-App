
import 'package:dunya/addproduct.dart';
import 'package:dunya/cart.dart';
import 'package:dunya/search.dart';
import 'package:dunya/splash1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'product-details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class customer extends StatefulWidget {
  const customer({Key? key}) : super(key: key);

  @override
  State<customer> createState() => _customerState();
}

class _customerState extends State<customer> {

  List products=[];

  var _firestoreinstance = FirebaseFirestore.instance;

  product() async{
    QuerySnapshot qn= await _firestoreinstance.collection('products').get();
    setState(() {
      for( int i=0; i<qn.docs.length; i++){
        products.add(
            {
              "decs": qn.docs[i]["decs"],
              "img": qn.docs[i]["img"],
              "name": qn.docs[i]["name"],
              "price": qn.docs[i]["price"],
            }
        );

      }
    });
    return qn.docs;
  }


  @override
  void initState() {
    product();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
            "Our Product", style: GoogleFonts.sansita(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.white,

        ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:20),
            child: IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>fetchData ('user-cart')));
            }, icon:Icon(Icons.shopping_cart,color: Colors.white,size: 35,)),
          )
        ],

        elevation: 0,
       // centerTitle: true,
      ),

      drawer: Drawer(
          backgroundColor: Colors.blueGrey[800],
          child: Container(
            height: double.infinity,
            width: double.infinity,
            //color: Colors.green,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/b1.jpg'),
                  fit: BoxFit.fill
              ),),
            child: ListView(
              children: [
                DrawerHeader(
                  child: Column(
                    children: const [
                      SizedBox(height: 10),
                      Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 70,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ListTile(
                  iconColor: Colors.white,
                  leading: const Icon(Icons.person,),
                  title:  Text(
                      FirebaseAuth.instance.currentUser!.email!,
                      style: TextStyle(color: Colors.white, fontSize: 20)
                  )
                ),


                ListTile(
                  iconColor: Colors.white,
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  onTap: () {
                    // Add Navigation logic here
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => splash1()));
                  },
                ),
              ],
            ),
          )),

      body:
      SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20,top:30),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    fillColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.blueGrey)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.blueGrey)),
                    hintText: "Click Here To Search",
                    hintStyle:GoogleFonts.acme(
                      fontSize:20,
                      color:Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
                  },
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      scrollDirection:Axis.vertical,
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio:1),
                      itemBuilder: (_, index){
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductDetails(products[index])));
                          },
                          child:
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                                boxShadow:[
                                  BoxShadow(
                                      color:Colors.grey , blurRadius: 5,spreadRadius: 0, offset: Offset(0.4,0.30)
                                  )
                                ]


                            ),
                            child: Card(
                              color: Colors.blueGrey[900],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),

                              elevation: 0,
                              child: Container(
                                child: Column(
                                  children: [
                                    AspectRatio(
                                        aspectRatio:2,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top:5),
                                          child: Image.network(products[index]['img'],),

                                        )),

                                    Padding(
                                      padding: const EdgeInsets.only(top:15,),
                                      child: Text('${products[index]['name']}',style: GoogleFonts.acme(
                                        fontSize:20,
                                        color:Colors.white,
                                      ),),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text('\$ ${products[index]['price'].toString()}',style: GoogleFonts.acme(
                                        fontSize:20,
                                        color:Colors.white,
                                      )),
                                    ),


                                  ],
                                ),
                              ),

                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
