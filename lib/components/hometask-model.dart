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
    final d = await http
        .get('https://stnk2a.herokuapp.com/hometasks?_sort=id:DESC&_limit=40');
    List l = json.decode(d.body);
    print(d.body);
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
    print(json.encode(gen));
    return gen;
  }

  List getCurrentWeek({DateTime now}) {
    now = now ?? new DateTime.now();
    int day = now.weekday;
    List week = [];
    print('day:' + day.toString());
    for (int i = DateTime.monday; i <= DateTime.friday; i++) {
      DateTime c =
          now.add(new Duration(days: i)).subtract(new Duration(days: day));
      String gen =
          "${c.year}-${(c.month < 10 ? '0' + c.month.toString() : c.month.toString())}-${(c.day < 10 ? '0' + c.day.toString() : c.day.toString())}";
      week.add(gen);
    }
    print(week.toString());
    return week;
  }
}
