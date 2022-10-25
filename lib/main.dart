import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:societ_act/controller_bindings.dart';
import 'package:societ_act/views/bottom_navy.dart';
import 'package:societ_act/views/home_screen.dart';
import 'package:societ_act/views/login_screen.dart';
import 'package:societ_act/views/onboarding_screen.dart';
import 'package:societ_act/views/signup_screen.dart';

void main() {
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'welcome',
      channelName: 'Welcome Notification',
      channelDescription: 'Notification for welcome',
    ),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        // statusBarColor is used to set Status bar color in Android devices.
        // statusBarColor: kContentColorLightTheme,

        // To make Status bar icons color white in Android devices.
        statusBarIconBrightness: Theme.of(context).brightness,

        // statusBarBrightness is used to set Status bar icon color in iOS.
        statusBarBrightness: Theme.of(context).brightness,
        // Here light means dark color Status bar icons.
      ),
    );
    return GetMaterialApp(
      initialBinding: ControllerBindings(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Color(0xFF457B9D),
        primaryColor: const Color(0xFFA8DADC),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline1: GoogleFonts.comfortaa(
            textStyle: const TextStyle(
              fontSize: 40,
              color: Color(0xFF1D3557),
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
      home: const SplashScreen(),
      routes: <String, WidgetBuilder>{
        'onboarding': (BuildContext context) => const OnboardingScreens(),
        'login': (BuildContext context) => const LoginScreen(),
        'signup': (BuildContext context) => const SignupScreen(),
        'home': (BuildContext context) => const HomeScreen(),
        'bottom-navy': (BuildContext context) => const BottomNavy(),
      },
    );
  }
}

// Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// Component UI
class _SplashScreenState extends State<SplashScreen> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    _checkIfLoggedIn();
    startTime();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    // check if token is there
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  /// Setting duration in splash screen
  startTime() async {
    return Timer(const Duration(milliseconds: 4500), navigatorPage);
  }

  /// To navigate layout change
  void navigatorPage() {
    Navigator.of(context)
        .pushReplacementNamed(_isLoggedIn ? "bottom-navy" : "onboarding");
  }

  @override
  void didChangeDependencies() {
    precacheImage(
        Image.asset('assets/vanessa-serpas-47_VDec63Mg-unsplash.jpg').image,
        context);
    super.didChangeDependencies();
  }

  /// Code Create UI Splash Screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          /// Set Background image in splash screen layout (Click to open code)
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
                  Image.asset('assets/vanessa-serpas-47_VDec63Mg-unsplash.jpg')
                      .image,
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            /// Set gradient black in image splash screen (Click to open code)
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.3),
                  Color.fromRGBO(0, 0, 0, 0.4)
                ],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 30.0),
                    ),

                    /// Text header "Welcome To" (Click to open code)
                    Text(
                      "Welcome to",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.white,
                            fontSize: constraints.maxWidth < 768 ? 20 : 40,
                          ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    /// Animation text Duapa Shop to choose Login with Hero Animation (Click to open code)
                    Text(
                      "SOCIETY ACTS",
                      style: GoogleFonts.bebasNeue(
                        color: Colors.white,
                        fontSize: constraints.maxWidth < 768 ? 40 : 60,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
