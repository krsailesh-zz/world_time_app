import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String? location;
  String? flag;
  String? url;
  String? time;
  bool? isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      Response res =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(res.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'];
      int hours = int.parse(offset.substring(1, 3));
      int minutes = int.parse(offset.substring(4, 6));

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: hours, minutes: minutes));

      isDayTime = (now.hour > 6 && now.hour < 20) ? true : false;

      time = DateFormat.jm().format(now);
    } catch (e) {
      print('cought error : $e');
      time = 'could not get time data';
    }
  }
}
