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
      //backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(loading! ? "loading":"Education Page"),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
            itemCount: listEdu == null? 0:listEdu?.length,
            itemBuilder: (context, index){
              PersonalEducationModel mList = listEdu![index];
              return ListTile(
                title: Text(mList.program),
                subtitle: Text(mList.school),
              );
            }),
      ),
    );
  }
}
