import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'document.dart';
import 'settings.dart';

final pdf = pw.Document();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<File> _image = [];
  final _picker = ImagePicker();
  File? croppedFile;

  getImageFile(ImageSource source) async {
    final image = await _picker.getImage(source: source);
    croppedFile = await ImageCropper.cropImage(
        sourcePath: image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    setState(() {
      _image.add(File(croppedFile!.path));
    });
  }

  createPDF() {
    for (var img in _image) {
      final image = pw.MemoryImage(img.readAsBytesSync());
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Expanded(child: pw.Image(image)); // Center
          }));
    }
  }

  savePDF() async {
    Directory? directory;
    var filename = DateTime.now();
    try {
      if (Platform.isAndroid){
        if(await _requestPermission(Permission.storage)){
          directory = await getExternalStorageDirectory();
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.storage)){
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
        File file = File(directory!.path+"/DS$filename.pdf");
        await file.writeAsBytes(await pdf.save());
        showPrintMessage("Success", "File Saved to Android/data/com.example.docscanner/files", Colors.green);

    } catch (e) {
      showPrintMessage("Oops", e.toString(), Colors.red);
    }
  }
  showPrintMessage(String title, String msg , Color color) {
    Flushbar(
      title: title,
      message: msg,
      backgroundColor: color,
      duration: Duration(seconds: 3),
    )..show(context);
  }
  Future<bool> _requestPermission(Permission permission) async{
    if(await permission.isGranted){
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted){
        return true;
      } else {
        return false;
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(65.0),
          child: Text(
            "SCAN-D",
            style: TextStyle(
              fontFamily: "Staatliches"
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Phoenix.rebirth(context);
            },
            child: Icon(
              Icons.restart_alt,
              color: Colors.white,
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            ListTile(
              title: Image.asset("assets/Icon.png"),
            ),
            ListTile(
              leading: Icon(Icons.laptop),
              title: TextButton(
                onPressed: (){

                },
                child: Text("Demo App", style: TextStyle(color: Colors.black),),
              ),
            ),
            ListTile(
              leading: Icon(Icons.document_scanner_outlined),
              title: TextButton(
                onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => Document()));
              },
              child: Text("Documentation",style: TextStyle(color: Colors.black),),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
                },
                child: Text("Settings",style: TextStyle(color: Colors.black),),
              ),
            ),
          ],
        ),
      ),
      body: Center(
          child: _image.length == 0
              ? Container(
                  margin: EdgeInsets.only(top: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset("assets/upload.png"),
                      Text(
                        "Scan Images and Upload",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFF5E63B6),
                        ),)
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _image.length,
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 2, 10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 260,
                            width: 238,
                            decoration: BoxDecoration(
                              color: Color(0xFFF6F5F5),
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFBBBFCA),
                                  offset: const Offset(
                                    2.0,
                                    2.0,
                                  ),
                                  blurRadius: 12.0,
                                  spreadRadius: 5.0,
                                )
                              ]
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 8.0),
                                  child: Image.file(
                                    _image[index],
                                    height: 200,
                                    width: 160,
                                  ),
                                ),
                                TextButton(
                                  onPressed: (){
                                    setState(() {
                                      _image.removeAt(index);
                                      index--;
                                    });
                                  },
                                  child: Icon(Icons.delete,color: Color(0xFF5E63B6),),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              return getImageFile(ImageSource.camera);
            },
            heroTag: UniqueKey(),
            child: const Icon(Icons.camera),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              return getImageFile(ImageSource.gallery);
            },
            heroTag: UniqueKey(),
            child: const Icon(Icons.photo_library),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton.extended(
            onPressed: () {
              createPDF();
              savePDF();
            },
            label: Text("Create PDF"),
            heroTag: UniqueKey(),
            icon: Icon(Icons.picture_as_pdf_rounded),
          ),
        ],
      ),
    );
  }
}
