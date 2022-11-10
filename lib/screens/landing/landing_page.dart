import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.flutter_dash,
            size: 100,
          ),
          SizedBox(height: 10),

          //Title
          Text(
            "Alvin's Portfolio App",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(height: 50),

          //Sub-title
          Text(
            "Please enter the access key",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),

          // textfield
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TextField(
                    decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Key",
                )),
              ),
            ),
          ),
          SizedBox(height: 10),

          //Or
          Text(
            "Or",
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(height: 10),

          //Scan Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                  child: Text(
                "Scan QR Code To Login",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )),
            ),
          ),
          SizedBox(height: 10),
        ],
      ))),
    );
  }
}
