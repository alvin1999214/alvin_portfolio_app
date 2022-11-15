import 'package:flutter/material.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({Key? educationPageKey}) : super(key: educationPageKey);

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Education Page"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Text(
            'Edu Page',
            style: TextStyle(color: Colors.blue, fontSize: 15),
          )
        ],
      )),
    );
  }
}
