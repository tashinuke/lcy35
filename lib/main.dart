import 'package:flutter/material.dart';
import 'package:asitable/components/subject-tabs.dart';

void main(){
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Расписание',
      theme: ThemeData(primaryColor: const Color(0xFF001A2B)),
      debugShowCheckedModeBanner: false,
      home: AFB(),
    );
  }
}