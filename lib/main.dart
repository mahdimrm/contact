import 'package:contact/screens/home_screen.dart';
import 'package:contact/screens/license_screen.dart';
import 'package:contact/Utils/network.dart';
import 'package:contact/screens/license_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Utils/network.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

Future<bool> isActive() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool('isActive') ?? false;
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Network.chechkInternet(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'iransans'),
      debugShowCheckedModeBanner: false,
      title: 'اپلیکیشن دفترچه تلفن',
      home: FutureBuilder(
        future: isActive(),
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return const HomeScreen();
          } else {
            return LicencseScreen();
          }
        },
      ),
    );
  }
}
