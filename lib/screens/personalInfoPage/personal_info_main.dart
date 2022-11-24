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
  bool? loading;
  PersonalInfoModel? mInfoObj;

  @override
  void initState() {
    super.initState();
    loading = true;
    fetchPersonalInfoModel().then((obj) => setState(() {
      mInfoObj = obj;
      loading = false;
    }));
  }

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
                        _detailedBody()
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
                  children: [
                    ListView.builder(
                        itemCount: 2,
                        itemExtent: 50.0, //强制高度为50.0
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(title: Text("$index"));
                        }
                    ),
                    Column(
                      children: [
                        Text("data")
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailedBody() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 2 / 5,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    Configure.profileBgImg,headers: getTokenHeaders()),
              ),
            ),
          ),
          Container(
            transform: Matrix4.translationValues(0.0, -41.0, 0.0),
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 90.0,
                      height: 90.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,

                      ),
                    ),
                    SizedBox(
                      width: 82.0,
                      height: 82.0,
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(Configure.profileImg,headers: getTokenHeaders())
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(5.0)),
                Text(
                  mInfoObj!.info.name,
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
                Padding(padding: EdgeInsets.all(5.0)),
                Text(
                  mInfoObj!.info.title,
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
                Padding(padding: EdgeInsets.all(9.0)),
                Padding(padding: EdgeInsets.all(9.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Icon(Icons.whatsapp),
                        Text(
                          'Whatsapp',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Icon(Icons.g_mobiledata),
                        Text(
                          'GitHub',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),

    );
  }
}