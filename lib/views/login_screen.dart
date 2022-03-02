import 'dart:convert';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:societ_act/models/user_class.dart';
import 'package:societ_act/services/server.dart';
import 'package:societ_act/views/bottom_navy.dart';
import 'package:societ_act/views/widgets/input_field.dart';
import 'package:societ_act/views/widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  // final LoginController controller = Get.put(LoginController());
  final GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  bool obsecure = true;

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              image: const AssetImage('assets/avatar-images.jpg'),
              fit: BoxFit.cover,
            ),
            Container(
              // height: MediaQuery.of(context).size.height >= 843.4
              //     ? MediaQuery.of(context).size.height - 200
              //     : MediaQuery.of(context).size.height < 843.4
              //         ? MediaQuery.of(context).size.height + 200
              //         : MediaQuery.of(context).size.height + 100,
              padding: const EdgeInsets.all(40),
              decoration:
                  const BoxDecoration(color: Color(0xFFEDF1F4), boxShadow: [
                BoxShadow(
                  color: Color(0xFF616263),
                  offset: Offset(0, -1),
                  blurRadius: 10.0,
                )
              ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Log In',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 30,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Welcome to SocietActs, please login\nto connect with others',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 15,
                        ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InputField(
                          label: 'Username',
                          hintText: 'Enter your username',
                          // enabled: !controller.loading.value,
                          controller: username,
                          obscureText: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (username) {
                            if (username == null || username.isEmpty) {
                              return "* Required";
                            } else if (username.length < 3) {
                              return "* Username should be at least 3 characters";
                            } else if (username.length > 15) {
                              return "* Username should not be greater than 15 characters";
                            } else {
                              return null;
                            }
                          },
                        ),
                        InputField(
                          label: 'Password',
                          hintText: 'Enter your password',
                          // enabled: !controller.loading.value,
                          controller: password,
                          obscureText: obsecure,
                          textCapitalization: TextCapitalization.none,
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return "* Required";
                            } else if (password.length < 6) {
                              return "* Password should be atleast 6 characters";
                            } else if (password.length > 15) {
                              return "* Password should not be greater than 15 characters";
                            } else {
                              return null;
                            }
                          },
                          sufIcon: IconButton(
                              icon: Icon(obsecure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              color: const Color(0xFF457B9D),
                              onPressed: () {
                                setState(() {
                                  obsecure = !obsecure;
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: GoogleFonts.comfortaa(
                            color: const Color(0xFFE63946),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: _isLoading == false
                        ? PrimaryButton(
                            text: 'Login',
                            onTap: () async {
                              if (_formKey!.currentState!.validate()) {
                                login();
                              }
                              // Navigator.of(context).pushNamed('bottom-navy');
                            },
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                            strokeWidth: 2,
                          )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: GoogleFonts.comfortaa(
                          color: const Color(0xFF457B9D),
                          fontSize: 13,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('signup');
                          },
                          child: Text(
                            "Sign up",
                            style: GoogleFonts.comfortaa(
                              color: const Color(0xFFE63946),
                              fontSize: 13,
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "By using this service you are agreeing to our",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.comfortaa(
                          color: const Color(0xFF457B9D),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Terms and Services",
                        style: GoogleFonts.comfortaa(
                          color: const Color(0xFF2266C5),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final result = await InternetAddress.lookup(baseUrl);
      if (result.isNotEmpty && result[0].address.isNotEmpty) {
        final response = await http.post(
          Uri.https(baseUrl, loginRoute, {
            'username': username.text,
            'password': password.text,
          }),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
        );

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);

          var userData = User.fromJson(jsonResponse);

          if (userData.data.message == 'Invalid Login Credentials') {
            setState(() {
              _isLoading = false;
            });
            await Flushbar(
              message: "Invalid Login Credentials",
              icon: const Icon(
                Icons.info_outline,
                size: 28.0,
                color: Color(0xFFE63946),
              ),
              backgroundColor: const Color(0xFF457B9D),
              duration: const Duration(seconds: 3),
              leftBarIndicatorColor: const Color(0xFFE63946),
            ).show(context);
          } else {
            setState(() {
              _isLoading = false;
            });
            SharedPreferences localStorage =
                await SharedPreferences.getInstance();
            localStorage.setString('token', userData.token!);
            localStorage.setString('user', jsonEncode(userData));

            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const BottomNavy(),
              ),
            );
            await Flushbar(
              message: "Login Successfull!",
              icon: const Icon(
                Icons.info_outline,
                size: 28.0,
                color: Colors.green,
              ),
              backgroundColor: const Color(0xFF457B9D),
              duration: const Duration(seconds: 3),
              leftBarIndicatorColor: Colors.green,
            ).show(context);
          }
        } else {
          setState(() {
            _isLoading = false;
          });
          await Flushbar(
            message: "Request failed with status: ${response.statusCode}.",
            icon: const Icon(
              Icons.info_outline,
              size: 28.0,
              color: Color(0xFFE63946),
            ),
            backgroundColor: const Color(0xFF457B9D),
            duration: const Duration(seconds: 3),
            leftBarIndicatorColor: const Color(0xFFE63946),
          ).show(context);
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        await Flushbar(
          message: "Please check your internet connection and try again",
          icon: const Icon(
            Icons.info_outline,
            size: 28.0,
            color: Color(0xFFE63946),
          ),
          backgroundColor: const Color(0xFF457B9D),
          duration: const Duration(seconds: 3),
          leftBarIndicatorColor: const Color(0xFFE63946),
        ).show(context);
      }
    } on SocketException catch (_) {
      setState(() {
        _isLoading = false;
      });
      await Flushbar(
        message: "Please check your internet connection and try again",
        icon: const Icon(
          Icons.info_outline,
          size: 28.0,
          color: Color(0xFFE63946),
        ),
        backgroundColor: const Color(0xFF457B9D),
        duration: const Duration(seconds: 3),
        leftBarIndicatorColor: const Color(0xFFE63946),
      ).show(context);
    }
  }
}
  // STATEFUL WIDGET CLOSING


