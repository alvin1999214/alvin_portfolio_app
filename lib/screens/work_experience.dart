import 'package:flutter/material.dart';

class WorkExperiencePage extends StatefulWidget {
  const WorkExperiencePage({Key? workExperiencePageKey})
      : super(key: workExperiencePageKey);

  @override
  State<WorkExperiencePage> createState() => _WorkExperiencePageState();
}

class _WorkExperiencePageState extends State<WorkExperiencePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Work Experience Page"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Text(
            'Work Experience Page',
            style: TextStyle(color: Colors.blue, fontSize: 15),
          )
        ],
      )),
    );
  }
}
