import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:asitable/components/hometask-viewer.dart';
import 'package:asitable/microcomponents/Styles.dart';
import 'package:asitable/microcomponents/Microfunctions.dart';
import 'package:fluentui_icons/fluentui_icons.dart';

// ignore: must_be_immutable
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
                elevation: 0,
                backgroundColor: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                content: Row(
                  children: [
                    Icon(
                      FluentSystemIcons.ic_fluent_error_circle_filled,
                      color: Theme.of(context).textTheme.bodyText1.color,
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Домашнего задания нет',
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                )));
          }
        },
        leading: Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, gradient: subjectState),
            child: CircleAvatar(
                child: Text("${order + 1}",
                    style: Theme.of(context).textTheme.bodyText1),
                backgroundColor: Colors.transparent)),
        title: Row(children: [
          Badge(
            position: BadgePosition.topEnd(top: 3, end: -20),
            showBadge: (task != null ? task.isNotEmpty : false),
            child: Text(
              " $name",
              style: Theme.of(context).textTheme.headline3,
            ),
          )
        ]),
        subtitle: Row(children: [
          Card(
            elevation: 0,
            color: Theme.of(context).accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
              // side: BorderSide(width: 1, color: Color(0xFF002741)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: Text(
                room,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(7.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: toHumanTime(this.timeOfStart, this.timeOfEnd, context),
            ),
          ),
        ]),
        trailing: Icon(
          FluentSystemIcons.ic_fluent_chevron_right_filled,
          size: 18,
        ));
  }
}
