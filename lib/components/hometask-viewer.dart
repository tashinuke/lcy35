import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class HometaskViewer extends StatelessWidget {
  Map task;

  HometaskViewer(this.task);

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF001A2B),
        appBar: AppBar(
            elevation: 0,
            title: Container(
              child: new Text(task['nameOfLesson'],
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w700)),
            )),
        body: Center(
            child: ListView(children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Text(task['date'],
                  style: TextStyle(
                      backgroundColor: Colors.white,
                      fontSize: 24.0,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w600))),
          Markdown(
              shrinkWrap: true,
              data: task['content'],
              selectable: true,
              styleSheet:
                  MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                p: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(fontSize: 18.0, color: Colors.white70),
                h1: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(fontSize: 24.0, color: Colors.white),
                h2: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(fontSize: 22.0, color: Colors.white),
                h3: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(fontSize: 20.0, color: Colors.white),
              ))
        ])));
  }
}
