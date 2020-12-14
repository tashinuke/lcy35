import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:asitable/components/hometask-viewer.dart';
import 'package:asitable/microcomponents/Styles.dart';
import 'package:asitable/microcomponents/Microfunctions.dart';
import 'package:fluentui_icons/fluentui_icons.dart';

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
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                backgroundColor: Color(0xFF002741),
                content: Row(
                  children: [
                    Icon(FluentSystemIcons.ic_fluent_error_circle_filled),
                    SizedBox(width: 20),
                    Text(
                      'Домашнего задания нет',
                      style: SimpleTS,
                    )
                  ],
                )));
          }
        },
        leading: Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, gradient: subjectState),
            child: CircleAvatar(
                child: Text("${order + 1}", style: SimpleTS),
                backgroundColor: Colors.transparent)),
        title: Row(children: [
          Badge(
            position: BadgePosition.topEnd(top: 3, end: -20),
            showBadge: (task != null ? task.isNotEmpty : false),
            child: Text(" $name", style: SimpleTS),
          )
        ]),
        subtitle: Row(children: [
          Card(
            elevation: 0,
            color: TashiColors['in'],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
              // side: BorderSide(width: 1, color: Color(0xFF002741)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: Text(room, style: SubtextTS),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: TashiColors['in'],
              borderRadius: BorderRadius.circular(7.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: toHumanTime(this.timeOfStart, this.timeOfEnd),
            ),
          ),
        ]),
        trailing: Icon(
          FluentSystemIcons.ic_fluent_chevron_right_filled,
          color: Colors.white,
          size: 18,
        ));
  }
}
