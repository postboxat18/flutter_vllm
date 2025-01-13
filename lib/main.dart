import 'package:flutter/material.dart';

import 'Home/UI/home.dart';
import 'Utils/sharedPrefs.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefs.init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
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
