import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

MarkdownStyleSheet markdownStylesTS(context) {
  return MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
    blockquote: Theme.of(context).textTheme.body1.copyWith(
        fontSize: 18.0, color: TashiColors['in'], fontFamily: 'Rubik'),
    p: Theme.of(context)
        .textTheme
        .body1
        .copyWith(fontSize: 18.0, color: Colors.white70, fontFamily: 'Rubik'),
    h1: Theme.of(context)
        .textTheme
        .body1
        .copyWith(fontSize: 24.0, color: Colors.white, fontFamily: 'Rubik'),
    h2: Theme.of(context)
        .textTheme
        .body1
        .copyWith(fontSize: 22.0, color: Colors.white, fontFamily: 'Rubik'),
    h3: Theme.of(context)
        .textTheme
        .body1
        .copyWith(fontSize: 20.0, color: Colors.white, fontFamily: 'Rubik'),
  );
}

const Map TashiColors = const <String, Color>{
  'bk': const Color(0xFF001A2B), // background
  'in': const Color(0xFF002741), // info
  'pr': const Color(0xFF62A3F2), // primary
  'sb': const Color(0xFFCFCFCF), // subtitle
  'tl': const Color(0xFFFFFFFF), // title
  'rp': const Color(0xAF0066FF), // transparent primary
};
const Map TashiGradients = {
  'red': const LinearGradient(
      colors: [Colors.pink, Colors.orange],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight),
  'blue': const LinearGradient(
      colors: [Colors.indigo, Colors.cyan],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight),
  'green': const LinearGradient(
      colors: [Colors.teal, Colors.lime],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight),
  'accent': const LinearGradient(
      colors: [Colors.blueAccent, Colors.lightBlueAccent],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight),
  'transparent': const LinearGradient(
      colors: [Colors.transparent, Colors.transparent],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight),
};

// ignore: non_constant_identifier_names
TextStyle LabelTS = TextStyle(
    fontSize: 16.0,
    fontFamily: 'Rubik',
    fontWeight: FontWeight.w600);
// ignore: non_constant_identifier_names
TextStyle TitleTS = TextStyle(
    fontSize: 20.0,
    fontFamily: 'Rubik',
    color: TashiColors['tl'],
    fontWeight: FontWeight.w700);
// ignore: non_constant_identifier_names
TextStyle SimpleTS = TextStyle(color: TashiColors['tl'], fontFamily: 'Rubik');
// ignore: non_constant_identifier_names
TextStyle SubtextTS = TextStyle(color: TashiColors['sb'], fontFamily: 'Rubik');
