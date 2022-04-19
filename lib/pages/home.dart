import 'dart:ui';

import 'package:animated_button/animated_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:ocr_application/utils/routes.dart';
import 'package:ocr_application/utils/scan.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  const Color(0xFF01a6e8),
                  // const Color(0xFF203A43),
                  const Color(0xFF1cc1e4),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),

          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/nsut_logo.png',height: 120.0,),
                    SizedBox(height: 10.0,),
                    Text('CTWS PROJECT OCR APP ',style: TextStyle(
                      fontFamily: 'Avenir Next LT Pro',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      wordSpacing: 2,
                      fontSize: 25,

                    ),),
                    SizedBox(height: 30.0,),
                    Text(
                      "A handy tool to extract text from images or using your camera",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Avenir Next LT Pro',
                        color: Colors.white,

                        wordSpacing: 2,
                        fontSize: 25,

                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(60.0),
                      child: Image.asset(
                        "assets/images/ocr_image.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Center(child: Text('This App can detect license no. of Vehicles\nby scanning no. plate \n\nUse Live Text Detection From camera \nor choose from gallery',textAlign:TextAlign.center,style: TextStyle(color: Colors.white,),)),
                    SizedBox(
                      height: 20,
                    ),
                    ScanPage(),
                    // SizedBox(
                    //   height: 50,
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Hero(
                      tag: Key("upload"),
                      child:AnimatedButton(
                        child: Text(
                          'UPLOAD FROM GALLERY',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        color: Color(0xffffdc4a),
                        onPressed: () { Navigator.pushNamed(context, MyRoutes.uploadpage);
                        setState(() {});},
                        enabled: true,
                        width: 250,
                        height: 50,
                        shadowDegree: ShadowDegree.dark,
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.pushNamed(context, MyRoutes.uploadpage);
                      //     setState(() {});
                      //   },
                      //   // hoverColor: Colors.orange,
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //       border: Border.all(color: Colors.white),
                      //     ),
                      //     height: 40,
                      //     width: 400,
                      //     child: Center(
                      //       child: Text(
                      //         "Upload Image",
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ),
                    // Align(alignment:Alignment.topRight,child: IconButton(onPressed: (){}, icon: Icon(Icons.info_outline,color: Colors.white,))),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
