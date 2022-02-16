import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societ_act/views/bottom_navy.dart';
import 'package:societ_act/views/location_screen.dart';
import 'package:societ_act/views/login_screen.dart';
import 'package:societ_act/views/onboarding_screen.dart';
import 'package:societ_act/views/signup_screen.dart';
import 'package:societ_act/views/welcom_screen.dart';
import 'package:societ_act/utils/hexconvert.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Societ Act',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Color(0xFF457B9D),
        primaryColor: const Color(0xFFA8DADC),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline1: GoogleFonts.comfortaa(
            textStyle: TextStyle(
              fontSize: 40,
              color: '1D3557'.toColor(),
              fontWeight: FontWeight.w800,
            ),
          ),
          bodyText1: GoogleFonts.comfortaa(
            fontSize: 17,
            color: const Color(0xFF457B9D),
          ),
          bodyText2: GoogleFonts.comfortaa(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1D3557),
          ),
        ),
      ),
      home: const OnboardingScreens(),
      routes: <String, WidgetBuilder>{
        'login': (BuildContext context) => const LoginScreen(),
        'signup': (BuildContext context) => const SignupScreen(),
        'welcome': (BuildContext context) => const WelcomeScreen(),
        'location': (BuildContext context) => const LocationScreen(),
        'bottom-navy': (BuildContext context) => const BottomNavy(),
      },
    );
  }
}
