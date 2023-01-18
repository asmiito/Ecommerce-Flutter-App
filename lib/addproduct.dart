import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dunya/admin-page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
class addproduct extends StatefulWidget {

  @override
  State<addproduct> createState() => _addproductState();
}

class _addproductState extends State<addproduct> {
  TextEditingController name=TextEditingController();
  TextEditingController decs=TextEditingController();
  TextEditingController img=TextEditingController();
  TextEditingController price=TextEditingController();

  late Map<String , dynamic> add;
  CollectionReference _colref= FirebaseFirestore.instance.collection('products');
  addproducts(){
    add={
      'name': name.text,
      'decs': decs.text,
      'img': img.text,
      'price': price.text
    };
    _colref.add(add).whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (context)=>admin())));
  }

  _buildTextField(
      TextEditingController controller,  String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
          color: Colors.white,),
      child: TextField(
        controller: controller,
        style:  GoogleFonts.abhayaLibre(
            fontSize: 25,
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.bold
        ),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle:  GoogleFonts.abhayaLibre(
                fontSize: 20,
                color: Colors.blueGrey[900],
                fontWeight: FontWeight.bold
            ),
            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text('Add Product',style: GoogleFonts.abhayaLibre(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),),
        ),
        //centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10,),
          child: Column(
            children: [
              Container(
                height: 300,
                child:
                Lottie.network(
                    'https://assets3.lottiefiles.com/packages/lf20_wXvd7g0NWI.json',
                    height:200,width: 200, fit: BoxFit.fill ),
              ),
              
              SizedBox(height:5),
              _buildTextField(name, 'ProductName'),
              SizedBox(height: 20,),
              _buildTextField(decs, 'ProductDescription',),
              SizedBox(height: 20,),
              _buildTextField(img, 'ProductImage'),
              SizedBox(height: 20,),
              _buildTextField(price, 'ProductPrice'),
              SizedBox(height: 20,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[500],
                      minimumSize: Size(350, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                      )

                  ),
                  onPressed: (){
                    addproducts();

                  }, child:Text('Add Product', style:
              GoogleFonts.abhayaLibre(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold


              ),))
            ],
          ),
        ),
      ),
    );
  }
}
