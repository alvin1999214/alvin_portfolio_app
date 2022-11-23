import 'package:alvin_portfolio_app/model/personal_experience_model.dart';
import 'package:flutter/material.dart';

class WorkExperienceDetails extends StatefulWidget{
  const WorkExperienceDetails({super.key,required this.workDetail});

  final PersonalExperienceModel workDetail;

  @override
  State<StatefulWidget> createState() => _WorkExperienceDetails();
}

class _WorkExperienceDetails extends State<WorkExperienceDetails>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Job Details"),
          backgroundColor: Color(0xff172633),
        ),
      body: Center(
        child: Text(
            widget.workDetail.position
        ),
      )
    );
  }

}