import 'package:flutter/material.dart';
import 'package:mobile/Screens/MainScreen.dart';

import '../Common/UnfocusOnTap.dart';

class AuthScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AuthScreenState();
  }
}


class _AuthScreenState extends State{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UnfocusOnTap(
        child: Scaffold(
          body: Container(
            width: double.infinity, // На всю ширину
            height: double.infinity, // На всю высоту
            color: Color.fromARGB(255, 254, 201, 98),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset("assets/images/eye_left.png"),
                      Image.asset("assets/images/eye_right.png"),
                    ]
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset("assets/images/duck_png.png"),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: EdgeInsets.only(bottom: 100),
                            child: Text("Регистрация",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 25,
                                )
                            )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: SizedBox(
                          width: 230,
                          height: 35,
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Email',
                              hintText: 'Введите ваш Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 150),
                        child: SizedBox(
                          width: 230,
                          height: 35,
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Пароль',
                              hintText: 'Введите пароль',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFB761),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 100, vertical: 18),
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: StadiumBorder(),
                    elevation: 3,
                  ),
                  child: Text("Войти"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}