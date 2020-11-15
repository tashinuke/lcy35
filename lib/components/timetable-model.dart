import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TimetableModel {
  String from;
  Future<List> getCachedData() async {
    var prefs = await SharedPreferences.getInstance();
    String hasBeen = prefs.getString('sheduleCache') ?? '';
    if (hasBeen != '') {
      Map data = json.decode(hasBeen);
      print('cached: ' + hasBeen);
      this.from = 'cache';
      return data['Shedule'];
    } else {
      print('error on fetch cached data');
      return await getFetchedData();
    }
  }
  
  TimetableModel();

  Future<List> getFetchedData() async {
    final prefs = await SharedPreferences.getInstance();
    final res = await http.get('https://stnk2a.herokuapp.com/thirty-five');
    var data = await json.decode((res.body));
    prefs.setString('sheduleCache', res.body);
    print('fetched: ' + data.toString());
    this.from = 'net';
    return data['Shedule'];
  }
}