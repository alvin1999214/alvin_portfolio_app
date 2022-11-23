import 'package:alvin_portfolio_app/model/personal_info_model.dart';
import 'package:alvin_portfolio_app/services/mobile_config_services.dart';
import 'package:alvin_portfolio_app/values/configure.dart';
import 'package:flutter/material.dart';

class PersonalInfoDetails extends StatefulWidget {
  @override
  State<PersonalInfoDetails> createState() => _PersonalInfoDetailsState();
}

class _PersonalInfoDetailsState extends State<PersonalInfoDetails> {
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
    if (mInfoObj != null) {
      return Scaffold(
        body: Column(
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
