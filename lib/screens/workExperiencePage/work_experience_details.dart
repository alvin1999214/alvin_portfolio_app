import 'package:alvin_portfolio_app/model/personal_experience_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/mobile_config_services.dart';

class WorkExperienceDetails extends StatefulWidget {
  const WorkExperienceDetails({super.key, required this.workDetail});

  final PersonalExperienceModel workDetail;

  @override
  State<StatefulWidget> createState() => _WorkExperienceDetails();
}

class _WorkExperienceDetails extends State<WorkExperienceDetails> {
  @override
  Widget build(BuildContext context) {
    Uri _url = Uri.parse(widget.workDetail.action);
    _launchUrl() async {
      if (!await launchUrl(_url)) {
        throw 'Could not launch $_url';
      }
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Job Details"),
          backgroundColor: Color(0xff172633),
        ),
        body: SingleChildScrollView(
          child: Container(
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
                // Warp content of card
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(widget.workDetail.image,headers: getTokenHeaders(),),
                  Divider(height: 12),
                  Text("Position: "),
                  SizedBox(height: 5),
                  Text(widget.workDetail.position),
                  SizedBox(height: 15),
                  Text("Company: "),
                  SizedBox(height: 5),
                  Text(widget.workDetail.companyName),
                  Divider(height: 12),
                  Text("Responsibility: "),
                  SizedBox(height: 5),
                  Text(widget.workDetail.responsibility),
                  Divider(height: 12),
                  Text("Programming Language:"),
                  SizedBox(height: 5),
                  Text(widget.workDetail.programLauguage),
                  Divider(height: 12),
                  Text("Skills Using: "),
                  SizedBox(height: 5),
                  Text(widget.workDetail.software),
                  Divider(height: 12),
                  Text("Company Website: "),
                  SizedBox(height: 5),
                  Text(widget.workDetail.action),
                  Divider(height: 12),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xff172633),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextButton(
                      onPressed: () {
                        _launchUrl();
                      },
                      child: Text(
                        'Visit Website',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  )
                ],
              )
          ),
        )
    );
  }
}
