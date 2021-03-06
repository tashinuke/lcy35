import 'package:flutter/material.dart';
import 'package:asitable/components/timetable-model.dart';
import 'package:asitable/components/subject-list.dart';
import 'package:asitable/components/hometask-model.dart';
import 'package:asitable/microcomponents/Styles.dart';
import 'package:asitable/microcomponents/Microfunctions.dart';
import 'package:asitable/components/hometask-creator.dart';
import 'package:fluentui_icons/fluentui_icons.dart';

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
  bool timetableSwitch = false;

  Widget build(BuildContext context) {
    var now = new DateTime.now();
    List week = ht.getCurrentWeek(
        now: (now.weekday <= 5
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
            return genList(
                data,
                (index, value) => Center(
                      child: new SubjectList(
                          value,
                          (hmt.containsKey(week[index])
                              ? hmt[week[index]]
                              : []),
                          timetableSwitch),
                    ));
          }

          return DefaultTabController(
            initialIndex: getDay(now),
            length: data.length,
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new HometaskCreator(data)));
                },
                child: Icon(
                  FluentSystemIcons.ic_fluent_compose_filled,
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                automaticallyImplyLeading: false,
                title: Text(
                  'Расписание',
                  style: Theme.of(context).textTheme.headline1,
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      (timetableSwitch
                          ? FluentSystemIcons.ic_fluent_clock_filled
                          : FluentSystemIcons.ic_fluent_clock_regular),
                      color: Theme.of(context).textTheme.bodyText1.color,
                    ),
                    onPressed: () async {
                      this.timetableSwitch = !this.timetableSwitch;
                      this.setState(() {});
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      FluentSystemIcons.ic_fluent_dark_theme_regular,
                    ),
                    onPressed: () {},
                    color: Theme.of(context).textTheme.bodyText1.color,
                  ),
                  IconButton(
                    splashColor: TashiColors['sb'],
                    onPressed: () async {
                      this.source = 'f';
                      this.setState(() {});
                    },
                    icon: Icon(
                      (model.from == 'cache'
                          ? FluentSystemIcons.ic_fluent_cloud_regular
                          : FluentSystemIcons.ic_fluent_cloud_filled),
                      color: Theme.of(context).textTheme.bodyText1.color,
                    ),
                  ),
                  IconButton(
                    splashColor: TashiColors['sb'],
                    onPressed: () async {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          backgroundColor: Theme.of(context).accentColor,
                          content: Row(
                            children: [
                              SizedBox(width: 20),
                              Text(
                                'Made by tashinuke with ❤️ for licey №35',
                              ),
                            ],
                          )));
                    },
                    icon: Icon(
                      FluentSystemIcons.ic_fluent_person_regular,
                      color: Theme.of(context).textTheme.bodyText1.color,
                    ),
                  )
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
                            child: Text(
                              tab['Name'],
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                      ],
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        gradient: tashiGradients(context)['accent'],
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
          return Text("${snapshot.error}");
        }
        return Scaffold(
            backgroundColor: TashiColors['bk'],
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Padding(
                padding: EdgeInsets.only(left: 0),
                child: Container(
                  child: Text('Расписание'),
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
