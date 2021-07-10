import 'package:flutter/material.dart';

const kTextDesign=TextStyle(
  letterSpacing: 1.0,
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
);
class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Text("Scan-D",
            style: TextStyle(
                fontFamily: "Staatliches"
            ),),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.folder),
              title: Text("Folder: \n Android/data/com.example.docscanner/files",style: kTextDesign,),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text("File name format: \n  DS(Date&Time)",style: kTextDesign,),
            )
          ],
        ),
      ),
    );
  }
}
