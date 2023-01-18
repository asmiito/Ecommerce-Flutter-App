import 'package:dunya/addproduct.dart';
import 'package:dunya/search.dart';
import 'package:dunya/splash1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'product-details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class admin extends StatefulWidget {
  const admin({Key? key}) : super(key: key);

  @override
  State<admin> createState() => _adminState();
}

class _adminState extends State<admin> {


  TextEditingController name =TextEditingController();
  TextEditingController decs =TextEditingController();
  TextEditingController img =TextEditingController();
  TextEditingController price =TextEditingController();

  CollectionReference ref= FirebaseFirestore.instance.collection('products');

  _TextField(
      TextEditingController controller, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: Colors.blueGrey)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.blueGrey[900]),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle:  GoogleFonts.sansita(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey[900]), // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
  }


  design(
      TextEditingController con ,String text
      ){
    return Container(
      child:TextField(
        controller: con,
        decoration: InputDecoration(
          labelText: text
        ),


      )
    );

  }

  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
     extendBodyBehindAppBar: true,

      appBar: AppBar(
       backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Sky Bags Store",
            style: GoogleFonts.sansita(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
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
                            Icons.ac_unit,
                            size: 70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(thickness: .06, color: Colors.orange),
                ListTile(
                  iconColor: Colors.white,
                  leading: const Icon(Icons.person),
                  title:
                  Text(
                  FirebaseAuth.instance.currentUser!.email!,
                      style: TextStyle(color: Colors.white, fontSize: 20)
                  )
                ),
                    // Add Navigation logic here
                ListTile(
                  iconColor: Colors.white,
                  leading: const Icon(Icons.add_box_sharp),
                  title: const Text('Add Product',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => addproduct()));

                    // Add Navigation logic here
                  },
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
             SizedBox(height: 10,),
             Padding(
               padding: EdgeInsets.only(left: 20, right: 20,top:20),
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
               child: StreamBuilder<QuerySnapshot>(
                 stream: ref.snapshots(),
                 builder: (context, snapshot) {
                   if (snapshot.hasData) {
                     return
                       Stack(
                         children: [
ListView.builder(

    itemCount: snapshot.data!.docs.length,

    itemBuilder: (context, index) {

                DocumentSnapshot doc = snapshot.data!.docs[index];

                return ListTile(

                  subtitle: SizedBox(
                    width:600,
                    child: Container(
                      height: 550,
                      width: 500,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          boxShadow:[
                            BoxShadow(
                                color:Colors.grey , blurRadius: 8,spreadRadius: 0, offset: Offset(0.4,0.30)

                            )

                          ]





                      ),

                      child: Card(
color: Colors.blueGrey[900],
                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            SizedBox(height: 5,),

                            Center(

                              child: SizedBox(

                                  width: 400,
                                  height: 120,

                                  child: Image.network(doc['img'],fit: BoxFit.contain
                                    , height: 250,width: 500,)),

                            ),

                            Padding(

                              padding: const EdgeInsets.only(left:10,bottom: 0),

                              child:Text(doc['name'],

                                style: GoogleFonts.amita(

                                fontSize:35,

                                color:Colors.white,

                              ),),

                            ),

                            Container(

                              margin: EdgeInsets.all(5),

                              decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(40),

                                  color: Colors.white

                              ),

                              child: Center(

                                child: Text('Product Description',style: GoogleFonts.acme(

                                  fontSize:25,

                                  color:Colors.blueGrey[900],

                                ),),

                              ),

                            ),



                            Padding(

                              padding: const EdgeInsets.only(left: 10),

                              child: Text(doc['decs'],style: GoogleFonts.acme(

                                fontSize:25,

                                color:Colors.white,

                              ),),

                            ),

                            Padding(

                              padding: const EdgeInsets.all(0),

                              child: Container(

                                margin: EdgeInsets.all(10),

                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(40),

                                    color: Colors.white

                                ),

                                child: Center(

                                  child: Text('Product Price',style: GoogleFonts.acme(

                                    fontSize:25,

                                    color:Colors.blueGrey[900],

                                  ),),

                                ),

                              ),

                            ),

                            Padding(

                              padding: const EdgeInsets.only(left: 30),

                              child:

                              Text(

                                  "\$ ${doc['price']}",

                                  style: GoogleFonts.sansita(

                                      fontSize: 20,

                                      fontWeight: FontWeight.bold,

                                      color: Colors.white

                                  )

                              ),

                            ),

                            Row(

                              //mainAxisAlignment: MainAxisAlignment.end,

                              //crossAxisAlignment: CrossAxisAlignment.end,

                              children: [

                                Padding(

                                  padding: const EdgeInsets.only(left: 75,top: 0),

                                  child: Container(

                                    margin: EdgeInsets.all(10),

                                    height: 50,

                                    width: 200,

                                    decoration: BoxDecoration(

                                      borderRadius: BorderRadius.circular(20),

                                      color: Colors.white,

                                    ),

                                    child: IconButton(

                                      onPressed: (){

                                        name.text=doc['name'];

                                        decs.text=doc['decs'];

                                        img.text=doc['img'];

                                        price.text=doc['price'];

                                        showDialog(context: context, builder: (context)=>Dialog(

                                          child: Container(

                                            decoration: BoxDecoration(

                                                borderRadius: BorderRadius.circular(30),

                                                color: Colors.blueGrey[900]

                                            ),

                                            child: Padding(

                                              padding: const EdgeInsets.all(10.0),

                                              child: ListView(

                                                shrinkWrap: true,

                                                children: [

                                                  _TextField(name, 'productname'),

                                                  SizedBox(height: 10,),

                                                  _TextField(decs, 'productdecsription'),

                                                  SizedBox(height: 10,),

                                                  _TextField(img, 'productimage'),

                                                  SizedBox(height: 10,),

                                                  _TextField(price, 'productprice'),

                                                  SizedBox(height: 20,),

                                                  ElevatedButton(

                                                      style: ElevatedButton.styleFrom(

                                                        backgroundColor: Colors.blueGrey[600],



                                                      ),

                                                      onPressed: (){

                                                        snapshot.data!.docs[index].reference.update({

                                                          "name": name.text,

                                                          "decs": decs.text,

                                                          "img": img.text,

                                                          "price": price.text

                                                        } ).whenComplete(() => Navigator.pop(context));



                                                      }, child: Text('Update Product', style: GoogleFonts.sansita(

                                                      fontSize: 20,

                                                      fontWeight: FontWeight.bold,

                                                      color: Colors.blueGrey[900]))),

                                                  SizedBox(height: 10,),

                                                  ElevatedButton(

                                                      style: ElevatedButton.styleFrom(

                                                        backgroundColor: Colors.blueGrey[600],



                                                      ),

                                                      onPressed: (){



                                                        snapshot.data!.docs[index].reference.delete().whenComplete(() => Navigator.pop(context));

                                                      }, child: Text('Delete Product', style: GoogleFonts.sansita(

                                                      fontSize: 20,

                                                      fontWeight: FontWeight.bold,

                                                      color: Colors.blueGrey[900])))



                                                ],

                                              ),

                                            ),

                                          ),

                                        ));



                                      }, icon: Icon(Icons.published_with_changes_rounded,color: Colors.blueGrey[900], size: 40,),),

                                  ),

                                ),

                              ],

                            ),

                          ],

                        ),

                      ),

                    ),

                  ),

                );

    })
                         ],
                       );
                   } else {
                     return Text("No data");
                   }
                 },
               ),
             ),
           ],
         ),
       ),
     )

    );
  }
}
