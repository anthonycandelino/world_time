import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {

  String location; // location name for UI
  String time; // the time in that location
  String flag; // url to asset flag icon
  String url; // location url for API endpoint

  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async {
    // make request 
    Response response = await get('http://worldtimeapi.org/api/timezone/$url');
    Map data = jsonDecode(response.body);

    // get properties from data
    String dateTime = data['datetime'];
    String offset = data['utc_offset'].substring(1,3);

    // create DateTime object
    DateTime now = DateTime.parse(dateTime);
    now = now.add(Duration(hours: int.parse(offset)));
    
    // set the time property
    time = now.toString();

  }
}