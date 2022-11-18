import 'package:alvin_portfolio_app/model/personal_education_model.dart';
import 'package:alvin_portfolio_app/services/mobile_config_services.dart';
import 'package:flutter/material.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({Key? educationPageKey}) : super(key: educationPageKey);

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  List<PersonalEducationModel>? listEdu;
  bool? loading;
  final String title = "Education";

  @override
  void initState() {
    super.initState();
    loading = true;
    fetchPersonalEducationModel().then((list) {
      setState(() {
        listEdu = list;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (listEdu != null) {
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
                background: Image.network(
                  'https://info.ehl.edu/hubfs/Blog-EHL-Insights/Blog-Header-EHL-Insights/invest%20-education.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  PersonalEducationModel mList = listEdu![index];
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
                        Image.network('https://www.cuhk.edu.hk/english/images/college/cw-chu.jpg'),
                        SizedBox(height: 10),
                        Text(
                          mList.program,
                          style: const TextStyle(
                            color: Color(0xff454F57),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          mList.school,
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
                childCount: listEdu!.length,
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
