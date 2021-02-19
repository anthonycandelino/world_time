import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // location name for UI
  String time; // the time in that location
  String flag; // url to asset flag icon
  String url; // location url for API endpoint
  bool isDaytime;

  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async {
    
    try {
      // make request 
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      // get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(0,3);

      // create DateTime object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));
      
      // set the time property
      isDaytime = (now.hour > 6 && now.hour < 19) ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      // set time value if error occurs
      time = 'Time data could not be retireved.';
    }
  }
}