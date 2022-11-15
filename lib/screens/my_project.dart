import 'package:flutter/material.dart';

class MyProjectPage extends StatefulWidget {
  const MyProjectPage({Key? myProjectPageKey}) : super(key: myProjectPageKey);

  @override
  State<MyProjectPage> createState() => _MyProjectPageState();
}

class _MyProjectPageState extends State<MyProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("My Project Page"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Text(
            'My Project Page',
            style: TextStyle(color: Colors.blue, fontSize: 15),
          )
        ],
      )),
    );
  }
}
