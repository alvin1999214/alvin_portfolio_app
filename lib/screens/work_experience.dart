import 'package:alvin_portfolio_app/services/mobile_config_services.dart';
import 'package:flutter/material.dart';

import '../model/personal_experience_model.dart';

class WorkExperiencePage extends StatefulWidget {
  const WorkExperiencePage({Key? workExperiencePageKey})
      : super(key: workExperiencePageKey);

  @override
  State<WorkExperiencePage> createState() => _WorkExperiencePageState();
}

class _WorkExperiencePageState extends State<WorkExperiencePage> {
  List<PersonalExperienceModel>? listWork;
  bool? loading;
  final String title = "Work Experience";

  @override
  void initState() {
    super.initState();
    loading = true;
    fetchPersonalExperienceModel().then((list) {
      setState(() {
        listWork = list;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (listWork != null) {
      return Scaffold(
        backgroundColor: Color(0xffF5F7F9),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              pinned: true,
              expandedHeight: 250,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(this.title,style: TextStyle(color: Color(0xff172633)),),
                background: Image(image: AssetImage('work.jpg'),),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  PersonalExperienceModel mList = listWork![index];
                  return Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 24.0),
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
                        ]
                    ),
                    child: Column(
                      children: [
                        Image.network('https://www.jobstreet.com.ph/career-resources/wp-content/uploads/sites/3/2014/07/Is-the-Company-Youre-Working-for-Stable.jpg'),
                        SizedBox(height: 10),
                        Text(
                          mList.position,
                          style: const TextStyle(
                            color: Color(0xff454F57),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          mList.companyName,
                          style: const TextStyle(
                              color: Color(0xff9BA4AB), fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(mList.from,
                                style: const TextStyle(
                                    color: Color(0xff9BA4AB), fontSize: 12)),
                            SizedBox(
                              width: 10,
                            ),
                            Text("to",
                                style: const TextStyle(
                                    color: Color(0xff9BA4AB), fontSize: 12)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(mList.to,
                                style: const TextStyle(
                                    color: Color(0xff9BA4AB), fontSize: 12))
                          ],
                        )
                      ],
                    ),
                  );
                },
                childCount: listWork!.length,
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: const Center(
          child: Text('Loading...',
              style: TextStyle(
                color: Color(0xff172633),
                fontSize: 20,
              )
          ),
        ),
      );
    }
  }
}
