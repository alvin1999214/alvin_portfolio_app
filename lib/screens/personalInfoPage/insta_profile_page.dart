// InstaProfilePage
import 'dart:math';

import 'package:alvin_portfolio_app/screens/personalInfoPage/personal_info_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/personal_info_model.dart';
import '../../services/mobile_config_services.dart';
import '../../values/configure.dart';

class InstaProfilePage extends StatefulWidget {
  const InstaProfilePage({Key? homePageKey}) : super(key: homePageKey);
  @override
  _InstaProfilePageState createState() => _InstaProfilePageState();
}

class _InstaProfilePageState extends State<InstaProfilePage> {
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
        title: Text('AppBar'),
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
              TabBar(
                tabs: [
                  Tab(text: 'A'),
                  Tab(text: 'B'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ListView.builder(
                        itemCount: 10,
                        itemExtent: 50.0, //强制高度为50.0
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(title: Text("$index"));
                        }
                    ),
                ListView.builder(
                    itemCount: 10,
                    itemExtent: 50.0, //强制高度为50.0
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(title: Text("$index"));
                    }
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
            height: MediaQuery.of(context).size.width * 3 / 4,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    'http://www.korea.kr/newsWeb/resources/attaches/2017.08/03/3737_cp.jpg'),
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
                          backgroundImage: NetworkImage('https://steemitimages.com/DQmS1gGYmG3vL6PKh46A2r6MHxieVETW7kQ9QLo7tdV5FV2/IMG_1426.JPG')
                      ),
                    ),
                    Container(
                        width: 90.0,
                        height: 90.0,
                        alignment: Alignment.bottomRight,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 28.0,
                              height: 28.0,
                              child: FloatingActionButton(
                                onPressed: null,
                                backgroundColor: Colors.white,
                                //child: Icon(Icons.add),
                              ),
                            ),
                            SizedBox(
                              width: 25.0,
                              height: 25.0,
                              child: FloatingActionButton(
                                onPressed: null,
                                child: Icon(Icons.add),
                              ),
                            ),
                          ],
                        )
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.all(5.0)),
                Text(
                  'nickname',
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
                Padding(padding: EdgeInsets.all(5.0)),
                Text(
                  'introduce',
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
                        Text(
                          '0',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '식물수',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          '0',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '팔로워',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          '0',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '팔로잉',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    )
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