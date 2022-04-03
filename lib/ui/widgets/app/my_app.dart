import 'package:flutter/material.dart';
import 'package:recipes/ui/widgets/bottom_navigation/bottom_navigation_widget.dart';

class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      home: BottomNavigationWidget(),
    );
  }
}
