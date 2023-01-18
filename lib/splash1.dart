import 'package:dunya/registraion.dart';
import 'package:dunya/welcome-page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class splash1 extends StatefulWidget {
  const splash1({Key? key}) : super(key: key);

  @override
  State<splash1> createState() => _splash1State();
}

class _splash1State extends State<splash1> {
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 16),(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>welcome()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[900]
        ,
        body:  Column(
          children: [
            Container(
             height:700,
              width:870,
              //decoration: BoxDecoration(
                //image: DecorationImage(
                  //image: AssetImage('assets/shop.png',),
                  //fit:BoxFit.fill,
                //)
              //),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Lottie.network(
                      'https://assets1.lottiefiles.com/packages/lf20_UnfRpxwc6d.json',
                      height:40,width: 0, fit: BoxFit.fill ),
            ),

            ),

            Padding(
              padding: const EdgeInsets.only(top:10, left: 20),
              child:
              Text('Sky Bag Store',style:GoogleFonts.amita(
                  fontSize: 44,
                  color: Colors.white,
                  fontWeight: FontWeight.bold

              )),
            ),
        SizedBox(height: 1,),
        CircularProgressIndicator(
          color: Colors.white,
        )


          ],
        )
    );
  }
}
