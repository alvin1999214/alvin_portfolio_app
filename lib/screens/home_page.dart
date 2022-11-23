import 'package:alvin_portfolio_app/screens/education.dart';
import 'package:alvin_portfolio_app/screens/my_project.dart';
import 'package:alvin_portfolio_app/screens/personalInfoPage/personal_info_main.dart';
import 'package:alvin_portfolio_app/screens/work_experience.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? homePageKey}) : super(key: homePageKey);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final screen = [
    PersonalInfoPage(),
    WorkExperiencePage(),
    EducationPage(),
    MyProjectPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: screen.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Personal Info',
            backgroundColor: Color(0xff172633),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Experience',
            backgroundColor: Color(0xff172633),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Education',
            backgroundColor: Color(0xff172633),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smartphone_outlined),
            label: 'MY Project',
            backgroundColor: Color(0xff172633),
          ),
        ],
        currentIndex: _selectedIndex,
        //selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
