import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societ_act/utils/input_field.dart';
import 'package:societ_act/utils/primary_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey();
  bool obsecure = true;
  int? gender;
  bool _isPartener = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          FontAwesomeIcons.angleLeft,
          color: Color(0xFF457B9D),
        ),
        backgroundColor: const Color(0xFFF1FAEE),
        centerTitle: true,
        title: Text(
          'Sign-up',
          style: GoogleFonts.comfortaa(
            color: const Color(0xFF457B9D),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _isPartener == false
                    ? Stack(
                        alignment: AlignmentDirectional.centerStart,
                        children: [
                          Container(
                            alignment: AlignmentDirectional.centerEnd,
                            width: 220,
                            height: 35,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFFEFF8F8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _isPartener = true;
                                });
                              },
                              child: Text(
                                'Partener',
                                style: GoogleFonts.comfortaa(
                                  fontSize: 12,
                                  color: const Color(0xFFA5B9D6),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 3,
                            child: Container(
                              alignment: AlignmentDirectional.center,
                              width: 110,
                              height: 30,
                              // padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Color(0xFFEDF1F4),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF7A7A7A),
                                    offset: Offset(1, 1),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'General User',
                                  style: GoogleFonts.comfortaa(
                                    fontSize: 12,
                                    color: const Color(0xFF1D3557),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          Container(
                            alignment: AlignmentDirectional.centerStart,
                            width: 220,
                            height: 35,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFFEFF8F8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _isPartener = false;
                                });
                              },
                              child: Text(
                                'General User',
                                style: GoogleFonts.comfortaa(
                                  fontSize: 12,
                                  color: const Color(0xFFA5B9D6),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 3,
                            child: Container(
                              alignment: AlignmentDirectional.center,
                              width: 110,
                              height: 30,
                              // padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Color(0xFFEDF1F4),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF7A7A7A),
                                    offset: Offset(1, 1),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Partener',
                                  style: GoogleFonts.comfortaa(
                                    fontSize: 12,
                                    color: const Color(0xFF1D3557),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                _isPartener == true
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: gender,
                              toggleable: true,
                              onChanged: (gender) {
                                setState(() {
                                  gender = 1;
                                });
                              },
                            ),
                            Text(
                              'Sponsor',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Radio(
                              value: 1,
                              groupValue: gender,
                              toggleable: true,
                              onChanged: (gender) {
                                setState(() {
                                  gender = 2;
                                });
                              },
                            ),
                            Text(
                              'Volunteer',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Radio(
                              value: 1,
                              groupValue: gender,
                              toggleable: true,
                              onChanged: (gender) {
                                setState(() {
                                  gender = 2;
                                });
                              },
                            ),
                            Text(
                              'Activist',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                const InputField(
                  label: 'Username',
                  hintText: 'Enter your username',
                  obscureText: false,
                  textCapitalization: TextCapitalization.none,
                ),
                const InputField(
                  label: 'Full Name',
                  hintText: 'Enter your full name',
                  obscureText: false,
                  textCapitalization: TextCapitalization.words,
                ),
                const InputField(
                  label: 'Email',
                  hintText: 'Enter your email',
                  obscureText: false,
                  textCapitalization: TextCapitalization.none,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: gender,
                        toggleable: true,
                        onChanged: (gender) {
                          setState(() {
                            gender = 1;
                          });
                        },
                      ),
                      Text(
                        'Male',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Radio(
                        value: 1,
                        groupValue: gender,
                        toggleable: true,
                        onChanged: (gender) {
                          setState(() {
                            gender = 2;
                          });
                        },
                      ),
                      Text(
                        'Female',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
                InputField(
                  label: 'Password',
                  hintText: 'Enter your password',
                  obscureText: obsecure,
                  textCapitalization: TextCapitalization.none,
                  sufIcon: IconButton(
                      icon: Icon(
                          obsecure ? Icons.visibility_off : Icons.visibility),
                      color: Colors.grey,
                      onPressed: () {
                        setState(() {
                          obsecure = !obsecure;
                        });
                      }),
                ),
                InputField(
                  label: 'Confirm Password',
                  hintText: 'Enter your confirm password',
                  obscureText: obsecure,
                  textCapitalization: TextCapitalization.none,
                  sufIcon: IconButton(
                      icon: Icon(
                          obsecure ? Icons.visibility_off : Icons.visibility),
                      color: Colors.grey,
                      onPressed: () {
                        setState(() {
                          obsecure = !obsecure;
                        });
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: PrimaryButton(
                    text: 'Sign-up',
                    onTap: () {
                      Navigator.of(context).pushNamed('welcome');
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
