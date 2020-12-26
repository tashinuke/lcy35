import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:asitable/components/MarkdownEditor/flutter_markdown_editor.dart';
import 'package:asitable/microcomponents/Styles.dart';
import 'package:asitable/microcomponents/Microfunctions.dart';
import 'package:fluentui_icons/fluentui_icons.dart';

class HometaskCreator extends StatefulWidget {
  List timetable;

  HometaskCreator(this.timetable, {Key key}) : super(key: key);

  @override
  HometaskCreatorState createState() => HometaskCreatorState(timetable);
}

class HometaskCreatorState extends State<HometaskCreator> {
  DateTime pickedDate = DateTime.now();
  List<String> timetable;
  String selectedSubject;
  List tt;

  HometaskCreatorState(this.tt);

  Widget build(BuildContext context) {
    var contrl = TextEditingController();
    final MarkDownEditor markDownEditor = MarkDownEditor(controller: contrl);
    this.timetable = List<String>.from(
        genList(tt[getDay(pickedDate)]['List'], (index, value) {
      return value['Name'];
    })).toSet().toList();
    print(this.timetable);
    Intl.defaultLocale = 'ru';
    selectedSubject =
        (timetable.contains(selectedSubject) ? selectedSubject : null) ??
            timetable[0];
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: IconButton(
              icon: Icon(
                FluentSystemIcons.ic_fluent_arrow_left_filled,
                color: Theme.of(context).textTheme.bodyText1.color,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            elevation: 0,
            title: Container(
              child: Text('Создать работу',
                  style: Theme.of(context).textTheme.headline1),
            )),
        body: Center(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${DateFormat('EEE, d MMMM').format(pickedDate)}"
                      .toUpperCase(),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                IconButton(
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: pickedDate,
                            firstDate: new DateTime(2020),
                            lastDate: new DateTime(2025),
                            locale: const Locale('ru'))
                        .then((date) {
                      this.setState(() {
                        pickedDate = date ?? pickedDate;
                      });
                    });
                  },
                  icon: Icon(
                    FluentSystemIcons.ic_fluent_calendar_filled,
                    color: Theme.of(context).textTheme.bodyText1.color,
                  ),
                ),
                DropdownButton<String>(
                  value: selectedSubject,
                  icon: Icon(
                    FluentSystemIcons.ic_fluent_chevron_down_filled,
                    color: Theme.of(context).textTheme.bodyText2.color,
                  ),
                  iconSize: 24,
                  elevation: 16,
                  dropdownColor: Theme.of(context).accentColor,
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      selectedSubject = newValue;
                    });
                  },
                  items:
                      timetable.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            Padding(
                child: markDownEditor.inPlace(),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                // side: BorderSide(width: 1, color: Color(0xFF002741)),
              ),
              onPressed: () async {
                var c = pickedDate;
                String gen =
                    "${c.year}-${(c.month < 10 ? '0' + c.month.toString() : c.month.toString())}-${(c.day < 10 ? '0' + c.day.toString() : c.day.toString())}";
                await http.post('https://stnk2a.herokuapp.com/hometasks',
                    body: {
                      'nameOfLesson': selectedSubject ?? 'monsun',
                      'content': contrl.text,
                      'date': gen
                    });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    backgroundColor: Color(0xFF002741),
                    content: Row(
                      children: [
                        Icon(Icons.done),
                        SizedBox(width: 20),
                        Text('Успешно создано')
                      ],
                    )));
                print('texted: ${{
                  'nameOfLesson': selectedSubject ?? 'monsun',
                  'content': contrl.text,
                  'date': gen
                }.toString()}');
              },
              child: Text(
                'Отправить',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            )
          ],
        )));
  }
}
