import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societ_act/utils/input_field.dart';
import 'package:societ_act/utils/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey();
  bool obsecure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              image: const AssetImage('assets/avatar-images.jpg'),
              fit: BoxFit.cover,
            ),
            Container(
              // margin: const EdgeInsets.only(top: 10),
              // width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height >= 843.4
                  ? MediaQuery.of(context).size.height - 200
                  : MediaQuery.of(context).size.height,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    height: 15,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const InputField(
                          label: 'Username',
                          hintText: 'Enter your username',
                          obscureText: false,
                          textCapitalization: TextCapitalization.none,
                        ),
                        InputField(
                          label: 'Password',
                          hintText: 'Enter your password',
                          obscureText: obsecure,
                          textCapitalization: TextCapitalization.none,
                          sufIcon: IconButton(
                              icon: Icon(obsecure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              color: Colors.grey,
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
                    child: PrimaryButton(
                      text: 'Login',
                      onTap: () {
                        Navigator.of(context).pushNamed('signup');
                      },
                    ),
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
                    height: 25,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "By using this service you are agreeing to our",
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
}
