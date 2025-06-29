import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'dart:io';
import 'Home/UI/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
        // scaffoldBackgroundColor: Colors.black87,
        // appBarTheme:  AppBarTheme(
        //   backgroundColor: Colors.black,
        //   titleTextStyle: TextStyle(color: Colors.white),
        // ),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
