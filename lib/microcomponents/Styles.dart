import 'package:flutter/material.dart';

const Map TashiColors = const <String, Color>{
  'bk': const Color(0xFF001A2B), // background
  'in': const Color(0xFF002741), // info
  'pr': const Color(0xFF62A3F2), // primary
  // light
  'inl': const Color(0xFFD8F1FF), // info
};
ThemeData th = ThemeData(
    splashColor: TashiColors['inl'],
    fontFamily: 'Rubik',
    scaffoldBackgroundColor: Colors.white,
    primaryColor: TashiColors['pr'],
    accentColor: TashiColors['inl'],
    textTheme: TextTheme(
        headline1: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 21,
            fontFamily: 'Rubik'),
        headline2: TextStyle(
            fontFamily: 'Rubik',
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 16),
        headline3: TextStyle(
            fontFamily: 'Rubik',
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 15),
        bodyText1: TextStyle(
            fontFamily: 'Rubik',
            color: Colors.black,
            fontWeight: FontWeight.w700),
        bodyText2: TextStyle(
            fontFamily: 'Rubik',
            color: Colors.blueGrey,
            fontWeight: FontWeight.w500)));
ThemeData thd = ThemeData(
    splashColor: TashiColors['in'],
    scaffoldBackgroundColor: TashiColors['bk'],
    primaryColor: TashiColors['pr'],
    accentColor: TashiColors['in'],
    textTheme: TextTheme(
        headline1: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 21,
            fontFamily: 'Rubik'),
        headline2: TextStyle(
            fontFamily: 'Rubik',
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16),
        headline3: TextStyle(
            fontFamily: 'Rubik',
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15),
        bodyText1: TextStyle(
            fontFamily: 'Rubik',
            color: Colors.white,
            fontWeight: FontWeight.w700),
        bodyText2: TextStyle(
            fontFamily: 'Rubik',
            color: Colors.blueGrey,
            fontWeight: FontWeight.w500)));

Map tashiGradients(context) {
  if (Theme.of(context).textTheme.bodyText1.color == Colors.white) {
    return {
      'red': LinearGradient(
          colors: [Colors.pink, Colors.orange],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight),
      'blue': LinearGradient(
          colors: [Colors.indigo, Colors.cyan],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight),
      'green': LinearGradient(
          colors: [Colors.teal, Colors.lime],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight),
      'accent': LinearGradient(
          colors: [Colors.blueAccent, const Color(0xFF62A3F2)],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight),
      'transparent': LinearGradient(
          colors: [Colors.transparent, Colors.transparent],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight),
    };
  } else {
    return {
      'red': LinearGradient(
          colors: [Colors.pink[100], Colors.orange[100]],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight),
      'blue': LinearGradient(
          colors: [Colors.indigo[100], Colors.cyan[100]],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight),
      'green': LinearGradient(
          colors: [Colors.teal[100], Colors.lime[100]],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight),
      'accent': LinearGradient(
          colors: [TashiColors['inl'], Colors.blue[100]],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight),
      'transparent': LinearGradient(
          colors: [Colors.transparent, Colors.transparent],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight),
    };
  }
}
