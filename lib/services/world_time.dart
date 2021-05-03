import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location; // Location name for UI
  String time; // Time in the location
  String flag; // URL to an asset flag icon
  String url; // Location URL for API endpoint
  bool isDaytime; // True or false if daytime or not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {

    try{
      // Make the request
      Response response = await get(Uri.https('worldtimeapi.org', '$url'));
      Map data = jsonDecode(response.body);

      // Get properties from json
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      // Create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // Set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print('caught error: $e');
      time = 'could not get time data';
      isDaytime = false;
    }
  }
}