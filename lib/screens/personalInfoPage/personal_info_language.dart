import 'package:alvin_portfolio_app/model/language_skill_model.dart';
import 'package:alvin_portfolio_app/services/mobile_config_services.dart';
import 'package:flutter/material.dart';

class PersonalInfoLanguage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PersonalInfoLanguageState();
}

class _PersonalInfoLanguageState extends State<PersonalInfoLanguage> {
  List<LanguageSkillModel>? mListLang;
  bool? loading;

  @override
  void initState() {
    super.initState();
    loading = true;
    fetchLanguageSkillModel().then((list) {
      setState(() {
        mListLang = list;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mListLang != null) {
      return Scaffold(
        backgroundColor: Color(0xffF5F7F9),
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  LanguageSkillModel mItem = mListLang![index];
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
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Programming Language: ",
                          style: TextStyle(fontSize: 14, color: Color(0xff9ba4ab)),),
                        Text(mItem.language,
                          style: TextStyle(fontSize: 16, color: Color(0xff172733)),),
                        SizedBox(height: 14,),
                        Text("Familiarity: ",
                          style: TextStyle(fontSize: 14, color: Color(0xff9ba4ab)),),
                        Text(mItem.rating,
                          style: TextStyle(fontSize: 16, color: Color(0xff172733)),)
                      ],
                    ),
                  );
                },
                childCount: mListLang!.length,
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
              )),
        ),
      );
    }
  }
}
