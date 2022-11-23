import 'dart:math';
import 'package:alvin_portfolio_app/model/personal_info_model.dart';
import 'package:alvin_portfolio_app/screens/personalInfoPage/personal_info_details.dart';
import 'package:alvin_portfolio_app/screens/personalInfoPage/personal_info_language.dart';
import 'package:alvin_portfolio_app/screens/work_experience.dart';
import 'package:alvin_portfolio_app/services/mobile_config_services.dart';
import 'package:alvin_portfolio_app/values/configure.dart';
import 'package:flutter/material.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({Key? homePageKey}) : super(key: homePageKey);

  @override
  _PersonalInfoPage createState() => _PersonalInfoPage();
}

class _PersonalInfoPage extends State<PersonalInfoPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool? loading;
  PersonalInfoModel? mInfoObj;
  final String title = "Personal Information";

  @override
  void initState() {
    super.initState();
    this.tabController = TabController(
      length: 2,
      vsync: this,
    );
    loading = true;
    fetchPersonalInfoModel().then((obj) {
      setState(() {
        mInfoObj = obj;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mInfoObj != null) {
      return Scaffold(
        backgroundColor: Color(0xffF5F7F9),
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Color(0xff172633),
                  pinned: true,
                  elevation: 0,
                  expandedHeight: 250,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(title),
                    background: Image.network(
                      Configure.profileBgImg,
                      headers: getTokenHeaders(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: StickyTabBarDelegate(
                    child: TabBar(
                      labelColor: Colors.black,
                      //controller: this.tabController,
                      tabs: <Widget>[
                        Tab(text: 'Profile'),
                        Tab(text: 'Programming Language'),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[
                PersonalInfoDetails(),
                PersonalInfoLanguage(),
              ],
            ),
          ),
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

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    //return this.child;
    return new Container(
      color: Colors.white,
      child: this.child,
    );
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
