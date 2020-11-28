import 'package:flutter/cupertino.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:asitable/microcomponents/Styles.dart';
List genList(List data, Function builder) {
  return data
      .asMap()
      .map((key, value) => MapEntry(key, builder(key, value)))
      .values
      .toList();
}

Widget toHumanTime(int start, int end) {
  return Row(children: [
    Text(
        "${start ~/ 60}:${start % 60 > 9 ? start % 60 : '0' + (start % 60).toString()} ", style: SubtextTS),
    Icon(FluentSystemIcons.ic_fluent_arrow_right_filled, color: TashiColors['sb'], size: 16),
    Text(
        " ${end ~/ 60}:${end % 60 > 9 ? end % 60 : '0' + (end % 60).toString()}", style: SubtextTS)
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
