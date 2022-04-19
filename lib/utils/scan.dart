import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';
import 'package:ocr_application/utils/routes.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  void initState() {
    super.initState();
    FlutterMobileVision.start().then((x) => setState(() {}));
  }

  static int OCR_CAM = FlutterMobileVision.CAMERA_BACK;
  static String word = "TEXT";

  Future<Null> _read() async {
    List<OcrText> texts = [];

    try {
      texts = await FlutterMobileVision.read(
        multiple: true,
        camera: OCR_CAM,
        waitTap: false,
        preview: FlutterMobileVision.PREVIEW,
      );
    } on Exception {
      texts.add(new OcrText('Failed to recognize text.'));
    }
    if (!mounted) return;
    setState(() {});
  }

  void backpressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, MyRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backpressed(context);
        return false;
      },
      child:  AnimatedButton(
        child: Text(
          'SCAN USING CAMERA',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        color: Color(0xffffdc4a),
        onPressed: () {_read();},
        enabled: true,
        width: 250,
        height: 50,
        shadowDegree: ShadowDegree.dark,
      ),
      // InkWell(
      //   onTap: () {
      //     _read();
      //     // Navigator.pushNamed(context, MyRoutes.scanpage);
      //     // setState(() {});
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
      //         "Scan Using Camera",
      //         style: TextStyle(
      //           color: Colors.white,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
