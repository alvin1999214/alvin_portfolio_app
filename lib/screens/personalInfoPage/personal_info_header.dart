import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../model/personal_info_model.dart';
import '../../services/mobile_config_services.dart';
import '../../values/configure.dart';

class PersonalInfoHeader extends StatefulWidget{
  const PersonalInfoHeader({Key? homePageKey}) : super(key: homePageKey);

  @override
  _PersonalInfoHeaderState createState() => _PersonalInfoHeaderState();
}
class _PersonalInfoHeaderState extends State<PersonalInfoHeader>{
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
    if(mInfoObj!=null){
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
                          backgroundColor: Color(0xff172633),

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

