import 'package:dunya/login.dart';
import 'package:dunya/registraion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';



class welcome extends StatefulWidget {
  const welcome({Key? key}) : super(key: key);

  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[900]
        ,
        body:
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 20),
              child:

              Container(
                height: 700,
                width: 600,
                child:
                Lottie.network(
                    'https://assets6.lottiefiles.com/packages/lf20_sop8cbmc.json',
                    height:200,width: 200, fit: BoxFit.fill ),
              ),
            ),

            SizedBox(height: 40,),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[700],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      minimumSize: Size(390,49)
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Register()));
                  },
                  child: Text('SignUp',style: GoogleFonts.acme(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,

                  ) ,)),
            ),
            SizedBox(height: 10,),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      minimumSize: Size(390,45)

                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                  }, child: Text('Login',style: GoogleFonts.acme(
                color: Colors.blueGrey[700],
                fontSize: 30,
                fontWeight: FontWeight.bold,

              ))),
            ),

          ],
        )
    );
  }
}

