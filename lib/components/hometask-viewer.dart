import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:asitable/microcomponents/Styles.dart';
import 'package:http/http.dart' as http;
import 'package:fluentui_icons/fluentui_icons.dart';

class HometaskViewer extends StatelessWidget {
  Map task;

  HometaskViewer(this.task);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(FluentSystemIcons.ic_fluent_arrow_left_filled,
                color: Theme.of(context).textTheme.bodyText1.color),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Container(
              child: new Text(
            task['nameOfLesson'],
            style: Theme.of(context).textTheme.headline1,
          )),
          actions: [
            IconButton(
              onPressed: () async {
                await http.delete(
                    'https://stnk2a.herokuapp.com/hometasks/${task['id']}');
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    backgroundColor: Theme.of(context).accentColor,
                    content: Row(
                      children: [
                        Icon(
                          FluentSystemIcons.ic_fluent_checkmark_filled,
                          color: Theme.of(context).textTheme.bodyText1.color,
                        ),
                        SizedBox(width: 20),
                        Text('Успешно удалено',
                            style: Theme.of(context).textTheme.bodyText1)
                      ],
                    )));
              },
              icon: Icon(
                FluentSystemIcons.ic_fluent_delete_filled,
                color: Theme.of(context).textTheme.bodyText1.color,
              ),
            )
          ],
        ),
        body: Center(
          child: Container(
              width: 900,
              child: Markdown(
                  onTapLink: (text, href, title) {
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Вы точно хотите перейти?'),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          insetPadding: EdgeInsets.symmetric(horizontal: 30),
                          backgroundColor: Color(0xFF002741),
                          content: SingleChildScrollView(
                            child: Text(
                              'Ссылка может содержать опасности',
                            ),
                          ),
                          actions: <Widget>[
                            CupertinoButton(
                                child: Text('Отмена',
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontFamily: 'Rubik')),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                            CupertinoButton(
                                child: Text('Перейти',
                                    style: TextStyle(
                                        color: Colors.lightBlueAccent,
                                        fontFamily: 'Rubik')),
                                onPressed: () {
                                  launch(href);
                                })
                          ],
                        );
                      },
                    );
                  },
                  styleSheet: MarkdownStyleSheet(
                      blockquote: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.black),
                      p: Theme.of(context).textTheme.bodyText1,
                      h1: Theme.of(context).textTheme.headline1,
                      h2: Theme.of(context).textTheme.headline2),
                  shrinkWrap: true,
                  data: '> Домашнее задание за ' +
                      task['date'] +
                      ":\n \n" +
                      task['content'],
                  selectable: true)),
        ));
  }
}
