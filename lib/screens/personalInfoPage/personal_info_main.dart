import 'package:alvin_portfolio_app/screens/personalInfoPage/personal_info_details.dart';
import 'package:alvin_portfolio_app/screens/personalInfoPage/personal_info_header.dart';
import 'package:alvin_portfolio_app/screens/personalInfoPage/personal_info_language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/personal_info_model.dart';
import '../../services/mobile_config_services.dart';
import '../../values/configure.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({Key? homePageKey}) : super(key: homePageKey);
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Persistent AppBar that never scrolls
      appBar: AppBar(
        title: Text('Personal Info'),
        backgroundColor: Color(0xff172633),
        elevation: 0.0,
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return <Widget> [
              SliverList(
//                itemExtent: 300,
                delegate: SliverChildListDelegate([
                  Container(
                    child: Column(
                      children: <Widget>[
                        PersonalInfoHeader()
                      ],
                    ),
                  )
                ]),
              ),
            ];
          },
          // You tab view goes here
          body: Column(
            children: <Widget>[
              Material(
                color: Color(0xff172633),
                child: Theme(
                  data: ThemeData().copyWith(splashColor: Colors.grey),
                  child: TabBar(
                    indicatorColor: Colors.grey,
                    tabs: [
                      Tab(text: 'Details'),
                      Tab(text: 'Programming Language'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    PersonalInfoDetails(),
                    PersonalInfoLanguage()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}