import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_weather_app/constants/constants.dart';
import 'package:intl/intl.dart';
import 'package:my_weather_app/services/weather.dart';

class WeatherDisplayScreen extends StatefulWidget {
  final weatherData;
  WeatherDisplayScreen({this.weatherData});

  @override
  _WeatherDisplayScreenState createState() => _WeatherDisplayScreenState();
}

class _WeatherDisplayScreenState extends State<WeatherDisplayScreen> {
  int temperature;
  int feelsLike;
  int minTemp;
  int maxTemp;
  int humidity;
  int windSpeed;
  String description;
  String cityName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    upDateUI(widget.weatherData);
  }

  void upDateUI(dynamic weatherData) => setState(() {
        if (weatherData == null) {
          temperature = 0;
          description = 'Unable to get data';
          feelsLike = 0;
          maxTemp = 0;
          minTemp = 0;
          humidity = 0;
          windSpeed = 0;
          cityName = '';
          return;
        }
        description = weatherData['weather'][0]['description'];
        temperature = weatherData['main']['temp'].toInt();
        feelsLike = weatherData['main']['feels_like'].toInt();
        minTemp = weatherData['main']['temp_min'].toInt();
        maxTemp = weatherData['main']['temp_max'].toInt();
        humidity = weatherData['main']['humidity'].toInt();
        windSpeed = weatherData['wind']['speed'].toInt();
        cityName = weatherData['name'];
      });

  Widget createIconButton({IconData icon, Function callback}) => FlatButton(
        onPressed: () => callback,
        child: Icon(
          icon,
          size: 35,
        ),
      );

  Widget createDisplayBox({String title, dynamic value}) => Expanded(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 2.0,
              color: Color(0xEEFFFFF),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            backgroundBlendMode: BlendMode.overlay,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.blueGrey.shade900,
              ],
            ),
          ),
          child: Column(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                thickness: 3.0,
                height: 5.0,
                color: Colors.white,
              ),
              Text(
                value.toString(),
                style: TextStyle(fontSize: 50.0),
              )
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Crystal Weather',
            style: GoogleFonts.lobster(
              textStyle: TextStyle(
                color: Colors.blueGrey.shade500,
                fontSize: 30,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  createIconButton(icon: Icons.my_location),
                  createIconButton(icon: Icons.show_chart)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        cityName,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        toBeginningOfSentenceCase(description),
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '🌩',
                    style: TextStyle(fontSize: 40),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        createDisplayBox(
                            title: 'Temperature', value: temperature),
                        SizedBox(width: 20),
                        createDisplayBox(title: 'Feels Like', value: feelsLike),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        createDisplayBox(title: 'Min. Temp', value: minTemp),
                        SizedBox(width: 20),
                        createDisplayBox(title: 'Max. Temp', value: maxTemp)
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        createDisplayBox(title: 'Humidity', value: humidity),
                        SizedBox(width: 20),
                        createDisplayBox(title: 'Wind Speed', value: windSpeed)
                      ],
                    ),
                  ],
                ),
              ),
              TextField(
                onChanged: (value) {
                  cityName = value;
                },
                decoration: kTextFieldStyle,
              ),
              FlatButton(
                onPressed: () async {
                  if (cityName != null) {
                    var weatherData =
                        await WeatherModel().getCityData(cityName);
                    upDateUI(weatherData);
                  }
                },
                child: Text(
                  'Get City Weather',
                  style: kButtonStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
