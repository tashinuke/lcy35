import 'package:flutter/material.dart';
import 'package:fluentui_icons/fluentui_icons.dart';

List genList(List data, Function builder) {
  return data
      .asMap()
      .map((key, value) => MapEntry(key, builder(key, value)))
      .values
      .toList();
}

Widget toHumanTime(int start, int end, context) {
  return Row(children: [
    Text(
      "${start ~/ 60}:${start % 60 > 9 ? start % 60 : '0' + (start % 60).toString()} ",
      style: Theme.of(context).textTheme.bodyText2,
    ),
    Icon(
      FluentSystemIcons.ic_fluent_arrow_right_filled,
      size: 16,
      color: Theme.of(context).textTheme.bodyText2.color,
    ),
    Text(
      " ${end ~/ 60}:${end % 60 > 9 ? end % 60 : '0' + (end % 60).toString()}",
      style: Theme.of(context).textTheme.bodyText2,
    )
  ]);
}

int getDay(DateTime now) {
  int day = now.weekday - 1;
  if (day < 5) {
    return day;
  } else {
    return 0;
  }
}
