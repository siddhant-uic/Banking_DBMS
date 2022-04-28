// ignore_for_file: prefer_const_constructors

import 'package:banking_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'services/auth.dart';
import 'LoginPage.dart';

void main() {
  runApp(const MyApp());
  currentCustomer = CurrentCustomer();
  currentEmployee = CurrentEmployee();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          appBarTheme: AppBarTheme(
            color: Colors.cyan,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.cyan,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
          ),
          textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white),
          inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              fillColor: Colors.blueGrey[700],
              hintStyle: TextStyle(color: Colors.white),
              iconColor: Colors.white,
              filled: true),
          scaffoldBackgroundColor: Colors.black),
      home: LoginPage(),
    );
  }
}
