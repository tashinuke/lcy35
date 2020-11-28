import 'package:asitable/components/subject-item.dart';
import 'package:flutter/material.dart';
import 'package:asitable/microcomponents/Styles.dart';
import 'package:asitable/microcomponents/Microfunctions.dart';

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
    if (tasks.isNotEmpty) {
      for (Map task in tasks) {
        if (task['nameOfLesson'] == name) {
          snap.add(task);
        }
      }
      return (snap.isNotEmpty ? snap[0] : {});
    }
  }

  Gradient whoLes(String s) {
    switch (s) {
      case "red":
        return TashiGradients['red'];
        break;
      case "blue":
        return TashiGradients['blue'];
        break;
      case "both":
        return TashiGradients['green'];
        break;
      default:
        return TashiGradients['transparent'];
        break;
    }
  }

  List<Subject> getList() {
    return List<Subject>.from(genList(
        weekday["List"],
        (index, value) => new Subject(
            index,
            value["Name"],
            cab(value["Cabinet"]),
            whoLes(value["Who"]),
            this.time[index]["start"],
            this.time[index]["end"],
            checkSubjectNames(value["Name"]))));
  }

  Widget build(BuildContext context) {
    return Container(
        width: 900,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: getList(),
        ));
  }
}
