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
  final String title = "Education Page";

  @override
  void initState() {
    // TODO: implement initState
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
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(this.title),
              background: Image.network(
                'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                PersonalEducationModel mList = listEdu![index];
                return Container(
                  height: 150,
                  color: Colors.white,
                  child: Center(
                    child: ListTile(
                      title: Text(mList.program),
                      subtitle: Text(mList.school),
                    ),
                  ),
                );
              },
              childCount: listEdu!.length,
            ),
            itemExtent: 300,
          ),
        ],
      ),
    );
  }
}
