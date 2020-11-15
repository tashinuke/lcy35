import 'package:asitable/components/subject-item.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class SubjectList extends StatelessWidget {
  final Map time = {
    0: {'start': 510, 'end': 550},
    1: {'start': 565, 'end': 605},
    2: {'start': 620, 'end': 660},
    3: {'start': 675, 'end': 715},
    4: {'start': 730, 'end': 770},
    5: {'start': 785, 'end': 825},
    6: {'start': 835, 'end': 875},
    7: {'start': 900, 'end': 1080},
  };
  Map weekday;
  List tasks;

  SubjectList(this.weekday, this.tasks);

  String cab(number) {
    if (number != 0) {
      return number.toString();
    } else {
      return 'Спортзал';
    }
  }

  Map checkSubjectNames(String name) {
    List snap = [];
    if(tasks.isNotEmpty){
    for (Map task in tasks) {
      if (task['nameOfLesson'] == name) {
        snap.add(task);
      }
    }
    return (snap.isNotEmpty ? snap[0] : {});
  }}

  Gradient whoLes(String s) {
    List<Color> color = [Colors.transparent, Colors.transparent];
    switch (s) {
      case "red":
        color = [Colors.pink, Colors.orange];
        break;
      case "blue":
        color = [Colors.indigo, Colors.cyan];
        break;
      case "both":
        color = [Colors.teal, Colors.lime];
        break;
    }
    return LinearGradient(
        colors: color, begin: Alignment.bottomLeft, end: Alignment.topRight);
  }

  List<Widget> getList() {
    List mapOfLessons = weekday["List"];
    return mapOfLessons
        .asMap()
        .map((index, value) => MapEntry(
            index,
            new Subject(
                index,
                value["Name"],
                cab(value["Cabinet"]),
                whoLes(value["Who"]),
                this.time[index]["start"],
                this.time[index]["end"],
                checkSubjectNames(value["Name"]))))
        .values
        .toList();
  }

  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: getList(),
    );
  }
}
