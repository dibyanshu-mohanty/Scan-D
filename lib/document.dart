import 'package:flutter/material.dart';


const kTextStyle = TextStyle(
  fontFamily: "Lobster",
  fontWeight: FontWeight.w300,
  fontSize: 16.0
);
const kWidth = SizedBox(width: 8,);
class Document extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){Navigator.pop(context);},),
        title: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Text("Scan-D",
            style: TextStyle(
                fontFamily: "Staatliches"
            ),),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "How to use this app :",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Teko"
                    ),
                  ),
                  Container(
                    width: 200,
                    child: Divider(
                      height: 2,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.camera),
                  kWidth,
                  Expanded(child: Text("Click on the Shutter icon, if you want to click a picture for the PDF.",style: kTextStyle,)),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.photo_library),
                  kWidth,
                  Expanded(child: Text("Click on the Gallery icon, if you want to choose Images from you device for thr PDF.",style: kTextStyle,)),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.picture_as_pdf_rounded),
                  kWidth,
                  Expanded(child: Text("After selecting the Images, click on the PDF icon to create your PDF.",style: kTextStyle,)),
                ],
              ),
              Text("This app is currently under Development!",style: kTextStyle,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning),
                  Text("Please Restart your app after you create a PDF",style: kTextStyle,),
                ],
              ),
              Text("App Created with 💖 by Dibyanshu Mohanty",style: kTextStyle)
            ],
          ),
        ),
      ),
    );
  }
}
