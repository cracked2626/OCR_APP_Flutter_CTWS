import 'dart:io';

import 'package:animated_button/animated_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  XFile? _imageFile;
  dynamic? _pickerror;
  bool showLoader=false;
  String? extracted = 'Recognised Extracted Text Will Appear Here';
  final picker = ImagePicker();
  _imgFromGallery() async {
    try {

      final image = await picker.pickImage(source: ImageSource.gallery);

      EasyLoading.show(status: 'loading...');
      if (image != null) {
        setState(() {
          showLoader=true;
        });
        // print(image.path);
        extracted = await FlutterTesseractOcr.extractText(image.path);
        setState(() {
          showLoader=false;
        });
      } else
        extracted = "Recogonised extracted text will be shown here";
      print(extracted);

      setState(() {
        if (image != null) {
          _imageFile = image;

          // if (_imageFile != null) {
          //   print(extracted);
          // } else
          //   extracted = "Recogonised extracted text will be shown here";
        }
      });
    } catch (e) {
      setState(() {
        _pickerror = e;
        print(e);
      });
    }
  }

  Widget preview() {
    if (_imageFile != null) {
      if (kIsWeb) {
        EasyLoading.dismiss();
        return Image.network(
          _imageFile!.path,
          fit: BoxFit.cover,
        );
      } else {
        EasyLoading.dismiss();
        return Semantics(
            child: Image.file(File(
              _imageFile!.path,
            )),
            label: 'image_picked_image');
      }
    } else if (_pickerror != null) {
      EasyLoading.dismiss();
      return Text(
        'Error: Select An Image (.PNG,.JPG,.JPEG,..) \nand Wait a Few Seconds',
        textAlign: TextAlign.center,
      );
    } else {
      EasyLoading.dismiss();
      return const Text(
        'You have not yet picked an image' +
            '\n' +
            'Pick an Image And Wait A few Seconds',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w500,),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  const Color(0xFFffff),
                  // const Color(0xFF203A43),
                  const Color(0xFFffff),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(children: [IconButton(onPressed: (){Navigator.of(context).pop();}, icon: Icon(Icons.arrow_back)),
              SizedBox(width: 30.0,),
              Text('Extract text from image',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
              ],),

              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                  children: [
                    SizedBox(height: 30.0,),
                Container(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.grey.shade100,borderRadius: BorderRadius.circular(8.0),boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],),
                    child: Center(child: preview()),
                    height: 250,
                    width: 650,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Hero(
                  tag: Key("upload"),
                  child: Center(
                    child: AnimatedButton(
                      child: showLoader?
                      SizedBox(height:20.0,width:20,child: CircularProgressIndicator(color: Colors.white,strokeWidth: 1.5,))
                          : Text(
                        'UPLOAD FROM GALLERY->',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Color(0xff01a9ea),
                      onPressed: () { _imgFromGallery();},
                      enabled: true,
                      width: 270,
                      height: 50,
                      shadowDegree: ShadowDegree.light,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.grey.shade100,borderRadius: BorderRadius.circular(8.0),boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SelectableText(
                        extracted.toString(),
                        style:
                        TextStyle(color: Colors.black, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],),)
            ],
          ),
        ),
      ),
    );
  }
}
