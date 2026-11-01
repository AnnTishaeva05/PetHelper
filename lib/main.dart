import 'package:flutter/material.dart';
import 'package:mobile/Screens/AuthScreen.dart';

import 'Screens/TrainingScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: AuthScreen(),
      routes: {
        '/training': (context) => TrainingScreen(),
      },
    );
  }
}



