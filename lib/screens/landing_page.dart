import 'package:alvin_portfolio_app/model/mobile_config_model.dart';
import 'package:alvin_portfolio_app/screens/home_page.dart';
import 'package:alvin_portfolio_app/services/mobile_config_services.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? landingPageKey}) : super(key: landingPageKey);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late Future<MobileConfig> futureMobileConfig;
  final TextEditingController accessKeyController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    // futureMobileConfig = fetchMobileConfig();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    accessKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Icon(
                      Icons.flutter_dash,
                      size: 100,
                    )),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: accessKeyController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Access Key',
                    hintText: ''),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 55.0),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) => HomePage()));
                  if (accessKeyController.text.isNotEmpty) {
                    futureMobileConfig =
                        fetchMobileConfig(accessKeyController.text, context);
                  }
                },
                child: Text(
                  'Get Access',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //TODO Scan QR code
              },
              child: Text(
                'Access by QR code',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}
