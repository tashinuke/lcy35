import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:asitable/components/timetable-model.dart';
import 'package:asitable/components/subject-list.dart';
import 'package:asitable/components/hometask-model.dart';
import 'package:http/http.dart';

class AFB extends StatefulWidget {
  // This widget is the root of your application.
  AFB({Key key}) : super(key: key);

  @override
  AFBstate createState() => AFBstate();
}

class AFBstate extends State<AFB> {
  HometaskModel ht = new HometaskModel();
  TimetableModel model = new TimetableModel();
  String source = '';

  Widget build(BuildContext context) {
    var now = new DateTime.now();
    List week = ht.getCurrentWeek(
        now: (now.weekday < 5
            ? now
            : now.add(new Duration(days: 8 - now.weekday))));
    return FutureBuilder(
      future: (source == 'f'
          ? Future(() async {
              var ha = await model.getFetchedData();
              var he = await ht.getFetchedData(w: week);
              return {'sh': ha, 'ht': he};
            })
          : Future(() async {
              return {
                'sh': await model.getCachedData(),
                'ht': await ht.getCachedData()
              };
            })),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List data = snapshot.data['sh'];
          Map hmt = snapshot.data['ht'];
          List getByDay(data) {
            print(week.toString());
            List it = data
                .asMap()
                .map((index, value) {
                  return MapEntry(
                      index,
                      new Center(
                        child: new SubjectList(
                            value,
                            (hmt.containsKey(week[index])
                                ? hmt[week[index]]
                                : [])),
                      ));
                })
                .values
                .toList();
            return it;
          }

          int getDay() {
            int day = now.weekday - 1;
            if (day < 5) {
              return day;
            } else {
              return 0;
            }
          }

          return DefaultTabController(
            initialIndex: getDay(),
            length: data.length,
            child: Scaffold(
              backgroundColor: Color(0xFF001A2B),
              appBar: AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                title: Container(
                  child: const Text('Расписание',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w700)),
                ),
                actions: [
                  FlatButton.icon(
                      onPressed: () async {
                        this.source = 'f';
                        this.setState(() {});
                      },
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                      label: Text(
                          (model.from == 'cache' ? 'Локальное' : 'Серверное'),
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Rubik')))
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TabBar(
                      labelPadding:
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                      physics: const BouncingScrollPhysics(),
                      isScrollable: true,
                      tabs: [
                        for (final tab in data)
                          Tab(
                            child: Text(tab['Name'],
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w600)),
                          ),
                      ],
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        gradient: LinearGradient(
                          colors: [Colors.blueAccent, Colors.cyan],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              body: TabBarView(
                physics: const BouncingScrollPhysics(),
                children: List<Widget>.from(getByDay(data)),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}",
              style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                  color: Colors.white70));
        }
        return Scaffold(
            backgroundColor: Color(0xFF001A2B),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Padding(
                padding: EdgeInsets.only(left: 0),
                child: Container(
                  child: const Text('Расписание',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w700)),
                ),
              ),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ));
      },
    );
  }
}
