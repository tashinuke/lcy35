import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

Future<List> getSubjects() async {
  final prefs = await SharedPreferences.getInstance();
  try {
    final res = await http.get('https://stnk2a.herokuapp.com/thirty-five');
    if (res.statusCode == 200) {
      var data = await json.decode((res.body));
      print('fetched: ' + data.toString());
      prefs.setString('cached', res.body);
      return data['Shedule'];
    }
  } on SocketException catch (_) {
    print('no connection');
    if (prefs.getString('cached') != '') {
      var data = json.decode(prefs.getString('cached'));
      print('cached: ' + data.toString());
      return data['Shedule'];
    } else {
      print('error datas');
      throw Exception('Failed to load album');
    }
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Расписание',
      theme: ThemeData(primaryColor: const Color(0xFF001A2B)),
      debugShowCheckedModeBanner: false,
      home: TabsOfItems(),
    );
  }
}

class TabsOfItems extends StatefulWidget {
  // This widget is the root of your application.
  TabsOfItems({Key key}) : super(key: key);

  @override
  TabsOfItemsState createState() => TabsOfItemsState();
}

class TabsOfItemsState extends State<TabsOfItems> {
  @override
  Future list = getSubjects();

  List<Widget> buildSubjectList(List<Object> list) {
    Widget buildWidget(index, value) {
      Map times = {
        1: '8:30 - 9:10',
        2: '9:25 - 10:05',
        3: '10:20 - 11:00',
        4: '11:15 - 11:55',
        5: '12:10 - 12:50',
        6: '13:05 - 13:45',
        7: '13:55 - 14:35',
        8: '15:00 - 18:00'
      };
      WhoLes() {
        Color color = Colors.transparent;
        switch (value["Who"]) {
          case "red":
            color = Colors.deepOrange;
            break;
          case "blue":
            color = Colors.blueAccent;
            break;
          case "both":
            color = Colors.teal;
            break;
        }
        return color;
      }

      String cab(number) {
        if (number != 0) {
          return number.toString();
        } else {
          return 'Спортзал';
        }
      }

      return new ListTile(
          leading: ExcludeSemantics(
            child: CircleAvatar(
                backgroundColor: WhoLes(),
                child: Text('${index + 1}',
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Rubik'))),
          ),
          title: Row(children: [
            Text(
              value['Name'] + '  ',
              style: TextStyle(color: Colors.white, fontFamily: 'Rubik'),
            ),
          ]),
          subtitle: Row(children: [
            Card(
              color: const Color(0xFF001A2B),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(width: 1, color: Colors.white70)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                child: Text(cab(value["Cabinet"]),
                    style: TextStyle(color: Colors.white, fontFamily: 'Rubik')),
              ),
            ),
            Card(
              color: Colors.blueGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                child: Text(times[index + 1],
                    style: TextStyle(color: Colors.white, fontFamily: 'Rubik')),
              ),
            ),
          ]),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.white,
          ));
    }

    return list
        .asMap()
        .map((index, value) => MapEntry(index, buildWidget(index, value)))
        .values
        .toList();
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: list,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var now = new DateTime.now();
          int getDay() {
            int day = now.weekday - 1;
            if (day < 5) {
              return day;
            } else {
              return 0;
            }
          }

          ;
          print(snapshot.hasData);
          return DefaultTabController(
            initialIndex: getDay(),
            length: snapshot.data.length,
            child: Scaffold(
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
                bottom: TabBar(
                  isScrollable: true,
                  tabs: [
                    for (final tab in snapshot.data)
                      Tab(
                        child: Text(tab['Name'],
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w600)),
                      ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  for (final tab in snapshot.data)
                    Center(
                      child: Scrollbar(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          children: buildSubjectList(tab['List']),
                        ),
                      ),
                    ),
                ],
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
