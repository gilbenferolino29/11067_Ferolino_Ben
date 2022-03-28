import 'package:flutter/material.dart';
import 'package:todo_app/src/screens/home.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'G-Todo App',
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.green[400]),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
