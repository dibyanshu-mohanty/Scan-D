import 'dart:async';

import 'package:flutter/material.dart';
import 'home.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() => runApp(Phoenix(child: DocScan()));

class DocScan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF5E63B6),
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Color(0xFF5E63B6))
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    super.initState();
    Timer(Duration(seconds: 4), () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/splash.png",
                          width: 200,
                          height: 200,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "SCAN-D",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            letterSpacing: 2.0,
                            fontFamily: "Staatliches",
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
              Expanded(
                flex: 1,
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center ,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(80.0, 0, 80.0, 10),
                        child: LinearProgressIndicator(
                          color: Colors.white,
                          backgroundColor: Color(0xFF5E63B6),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      Text(
                        "Made with ❤️ in 🇮🇳" ,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w900
                        ),
                      )
                    ],
              ))
            ],
          )
        ],
      ),
    );
  }
}
