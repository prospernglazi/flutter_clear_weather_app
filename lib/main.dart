import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_weather_app/screens/loading_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.oswaldTextTheme().copyWith(
          bodyText2: GoogleFonts.oswald(
            textStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
      home: LoadingScreen(),
    );
  }
}
