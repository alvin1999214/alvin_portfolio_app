import 'package:alvin_portfolio_app/model/personal_experience_model.dart';
import 'package:flutter/material.dart';

class WorkExperienceDetails extends StatefulWidget {
  const WorkExperienceDetails({super.key, required this.workDetail});

  final PersonalExperienceModel workDetail;

  @override
  State<StatefulWidget> createState() => _WorkExperienceDetails();
}

class _WorkExperienceDetails extends State<WorkExperienceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Job Details"),
          backgroundColor: Color(0xff172633),
        ),
        body: Container(
            // distant between content and edge
            padding: const EdgeInsets.all(20),
            // match parent of card
            width: double.infinity,
            // distant between card and parent
            margin:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )
                ]),
            child: Column(
              // Align Column to left by "CrossAxisAlignment.start"
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.workDetail.position),
                Text(widget.workDetail.companyName),
              ],
            )
        )
    );
  }
}
