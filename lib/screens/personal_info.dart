import 'package:flutter/material.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({Key? personalInfoPageKey})
      : super(key: personalInfoPageKey);

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Personal Page"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Text(
            'Personal Page',
            style: TextStyle(color: Colors.blue, fontSize: 15),
          )
        ],
      )),
    );
  }
}
