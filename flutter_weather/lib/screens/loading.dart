import 'package:flutter/material.dart';
import 'package:flutter_weather/data/my_location.dart';
import 'package:flutter_weather/data/network.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  double latitude, longtitude;

  @override
  void initState() {
    getLocation();
    //fetchData();
    super.initState();
  }

  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude = myLocation.latitude;
    longtitude = myLocation.longtitude;
    print(latitude);
    print(longtitude);

    Network network = Network(
        'https://samples.openweathermap.org/data/2.5/weather?q=London&appid=b1b15e88fa797225412429c1c50c122a1');

    var weatherData = await network.getJsonData();
    print(weatherData);
  }

  /*void fetchData() async {
    
      var myJson = parsingData['weather'][0]['description'];
      print(myJson);

      var wind = parsingData(jsonData)['wind']['speed'];
      print(wind);

      var id = parsingData(jsonData)['id'];
      print(id);
    } else {
      print(response.statusCode);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        child: Text('Get Location'),
        onPressed: () {},
      )),
    );
  }
}
