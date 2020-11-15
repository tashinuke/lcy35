import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:asitable/components/timetable-model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HometaskModel {
  TimetableModel shedule;

  //HometaskModel(this.shedule);

  // ignore: missing_return
  Future getCachedData() async {
    var prefs = await SharedPreferences.getInstance();
    String hasBeen = prefs.getString('hometasksCache') ?? '';
    if (hasBeen != '') {
      return json.decode(prefs.getString('hometasksCache'));
    } else {
      return await getFetchedData();
    }
  }

  Future getFetchedData({List w}) async {
    var prefs = await SharedPreferences.getInstance();
    final d = await http.get('https://stnk2a.herokuapp.com/hometasks');
    List l = json.decode(d.body);
    Map gen = {};
    w = w ?? getCurrentWeek();

    w.forEach((cx) {
      //Список эл. которые схожи по дате
      List el = [];
      l.forEach((cy) {
        if (cy['date'] == cx) {
          el.add(cy);
        }
      });
      if (el.isNotEmpty) {
        gen[cx] = el;
      }
    });
    prefs.setString('hometasksCache', json.encode(gen));
    return gen;
  }

  List getCurrentWeek({DateTime now }) {
    now = now ?? new DateTime.now();
    int day = now.weekday;
    List week = [];
    for (int i = DateTime.monday; i <= DateTime.friday; i++) {
      DateTime c = now.add(new Duration(days: i)).subtract(
          new Duration(days: day));
      String gen = "${c.year}-${c.month}-${c.day}";
      week.add(gen);
    }
    return week;
  }

  // ignore: missing_return
  Future createTask() {

  }

  // ignore: missing_return
  Future updateTask() {

  }
}