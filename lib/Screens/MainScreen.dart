import 'package:flutter/material.dart';
import 'package:mobile/Common/UnfocusOnTap.dart';

import 'ProfileScreen.dart';
import 'TrainingScreen.dart';
import 'FoodScreen.dart';
import 'HealthScreen.dart';

class MainScreen extends StatefulWidget{
  @override
  State<MainScreen> createState() {

    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen>{
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    TrainingScreen(),
    FoodScreen(),
    HelthScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Color.fromARGB(255, 254, 201, 98),
        title: Image.asset("assets/images/eye_and_noyse.png",
          height: 110,
          width: 110,
        ),
      ),
      body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromARGB(255, 253, 201, 94),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.sports_baseball_outlined),
              icon: Icon(Icons.sports_baseball_outlined),
              label: 'Тренировка',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.set_meal_sharp),
              icon: Icon(Icons.set_meal_sharp),
              label: 'Питание',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.medical_services),
              icon: Icon(Icons.medical_services),
              label: 'Здоровье',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.person),
              icon: Icon(Icons.person),
              label: 'Профиль',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color.fromARGB(255, 255, 255, 255),
          unselectedItemColor: Color.fromARGB(255, 138, 77, 5),
          onTap: _onItemTapped,
        )
    );
  }
}
