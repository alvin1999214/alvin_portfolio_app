import 'dart:math';
import 'package:alvin_portfolio_app/model/personal_info_model.dart';
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
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
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
                  controller: this.tabController,
                  tabs: <Widget>[
                    Tab(text: 'Home'),
                    Tab(text: 'Profile'),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                controller: this.tabController,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              Configure.profileImg,
                              headers: getTokenHeaders(),
                              width: 130,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 16)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                mInfoObj!.info.name,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Text(
                                "Phone: ${mInfoObj!.info.phone}",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF999999),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 2)),
                              Text(
                                "Address: ${mInfoObj!.info.address}",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF999999),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 2)),
                              Text(
                                "Github: ${mInfoObj!.info.github}",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF999999),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(height: 32),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Career Objective',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            mInfoObj!.careerObjective,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF999999),
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 32),
                    ],
                  ),
                  Center(child: Text('Content of Profile')),
                ],
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

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
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
