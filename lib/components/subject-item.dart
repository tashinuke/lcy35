import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:asitable/components/hometask-viewer.dart';

String toHumanTime(int start, int end) {
  return "${start ~/ 60}:${start % 60 > 9 ? start % 60 : '0' + (start % 60).toString()} - ${end ~/ 60}:${end % 60 > 9 ? end % 60 : '0' + (end % 60).toString()}";
}

class Subject extends StatelessWidget {
  String room;
  int timeOfStart;
  int timeOfEnd;
  int order;
  String name;
  Gradient subjectState;
  Map task;

  Subject(this.order, this.name, this.room, this.subjectState, this.timeOfStart,
      this.timeOfEnd, this.task);

  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          if (task != null && task.isNotEmpty) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new HometaskViewer(task)));
          } else {
            Scaffold.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                backgroundColor: Color(0xFF002741),
                content: Row(
                  children: [
                    Icon(Icons.error),
                    SizedBox(width: 20),
                    Text('Домашнего задания нет')
                  ],
                )));
          }
        },
        leading: Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, gradient: subjectState),
            child: CircleAvatar(
                child:
                    Text("${order + 1}", style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.transparent)),
        title: Row(children: [
          Badge(
            position: BadgePosition.topEnd(top: -3, end: -12),
            showBadge: (task != null ? task.isNotEmpty : false),
            child: Text(
              " $name",
              style: TextStyle(color: Colors.white, fontFamily: 'Rubik'),
            ),
          )
        ]),
        subtitle: Row(children: [
          Card(
            elevation: 0,
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
                side: BorderSide(width: 1, color: Colors.white70)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: Text(room,
                  style: TextStyle(color: Colors.white, fontFamily: 'Rubik')),
            ),
          ),
          Card(
            elevation: 0,
            color: Colors.blueGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: Text(toHumanTime(this.timeOfStart, this.timeOfEnd),
                  style: TextStyle(color: Colors.white, fontFamily: 'Rubik')),
            ),
          ),
        ]),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.white,
        ));
  }
}
