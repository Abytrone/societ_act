import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societ_act/controllers/radiobutton_controller.dart';
import 'package:societ_act/models/error_class.dart';
import 'package:societ_act/models/user_class.dart';
import 'package:societ_act/services/server.dart';
import 'package:societ_act/views/welcom_screen.dart';
import 'package:societ_act/views/widgets/input_field.dart';
import 'package:societ_act/views/widgets/primary_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final RadioButtonController radioButtonController =
      Get.put(RadioButtonController());
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController affiliation = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool obsecure = true;
  bool cobsecure = true;
  bool _isPartener = true;
  bool _isLoading = false;

  @override
  void initState() {
    radioButtonController.selectedGender.value = 'Male';
    super.initState();
  }

  String representations = 'Individual';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            FontAwesomeIcons.angleLeft,
            color: Color(0xFF457B9D),
          ),
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
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: constraints.maxWidth < 768 ? 20 : 100.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  _isPartener == true
                      ? Stack(
                          alignment: AlignmentDirectional.centerStart,
                          children: [
                            Container(
                              alignment: AlignmentDirectional.centerEnd,
                              width: constraints.maxWidth < 768 ? 220 : 350,
                              height: constraints.maxWidth < 768 ? 35 : 45,
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
                                    fontSize:
                                        constraints.maxWidth < 768 ? 12 : 20,
                                    color: const Color(0xFFA5B9D6),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 3,
                              child: Container(
                                alignment: AlignmentDirectional.center,
                                width: constraints.maxWidth < 768 ? 110 : 190,
                                height: constraints.maxWidth < 768 ? 30 : 40,
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
                                    'Partner',
                                    style: GoogleFonts.comfortaa(
                                      fontSize:
                                          constraints.maxWidth < 768 ? 12 : 20,
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
                              width: constraints.maxWidth < 768 ? 220 : 350,
                              height: constraints.maxWidth < 768 ? 35 : 45,
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
                                  'Partner',
                                  style: GoogleFonts.comfortaa(
                                    fontSize:
                                        constraints.maxWidth < 768 ? 12 : 20,
                                    color: const Color(0xFFA5B9D6),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 3,
                              child: Container(
                                alignment: AlignmentDirectional.center,
                                width: constraints.maxWidth < 768 ? 110 : 190,
                                height: constraints.maxWidth < 768 ? 30 : 40,
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
                                      fontSize:
                                          constraints.maxWidth < 768 ? 12 : 20,
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
                          padding: EdgeInsets.only(
                              top: constraints.maxWidth < 768 ? 10.0 : 20),
                          child: Row(
                            children: [
                              Obx(() {
                                return Radio(
                                  value: '1',
                                  groupValue: radioButtonController
                                      .selectedPartener.value,
                                  activeColor: const Color(0xFFA8DADC),
                                  fillColor: MaterialStateProperty.all(
                                      const Color(0xFF1D3557)),
                                  onChanged: (value) {
                                    radioButtonController.partenerChange(value);
                                  },
                                );
                              }),
                              Text(
                                'Sponsor',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize:
                                          constraints.maxWidth < 768 ? 12 : 24,
                                    ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Obx(() {
                                return Radio(
                                  value: '2',
                                  groupValue: radioButtonController
                                      .selectedPartener.value,
                                  activeColor: const Color(0xFFA8DADC),
                                  fillColor: MaterialStateProperty.all(
                                      const Color(0xFF1D3557)),
                                  onChanged: (value) {
                                    radioButtonController.partenerChange(value);
                                  },
                                );
                              }),
                              Text(
                                'Volunteer',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize:
                                          constraints.maxWidth < 768 ? 12 : 24,
                                    ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Obx(() {
                                return Radio(
                                  value: '3',
                                  groupValue: radioButtonController
                                      .selectedPartener.value,
                                  activeColor: const Color(0xFFA8DADC),
                                  fillColor: MaterialStateProperty.all(
                                      const Color(0xFF1D3557)),
                                  onChanged: (value) {
                                    radioButtonController.partenerChange(value);
                                  },
                                );
                              }),
                              Text(
                                'Activist',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize:
                                          constraints.maxWidth < 768 ? 12 : 24,
                                    ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  _isPartener == true
                      ? Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: DropdownButtonFormField<String>(
                            // value: representations,
                            elevation: 16,
                            icon: Icon(
                              FontAwesomeIcons.angleDown,
                              color: Color(0xFF1D3557),
                            ),
                            decoration: InputDecoration(
                              label: Text(
                                'Select Group',
                                style: GoogleFonts.comfortaa(
                                  fontSize:
                                      constraints.maxWidth < 768 ? 15 : 25,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF1D3557),
                                ),
                              ),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                representations = newValue!;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "* Required";
                              } else {
                                return null;
                              }
                            },
                            items: <String>['Individual', 'Group', 'Corporate']
                                .map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: GoogleFonts.comfortaa(
                                      fontSize:
                                          constraints.maxWidth < 768 ? 17 : 25,
                                      color: const Color(0xFF457B9D),
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        )
                      : Container(),
                  InputField(
                    label: 'Username',
                    hintText: 'Enter your username',
                    constraints: constraints,
                    // enabled: !controller.loading.value,
                    controller: username,
                    obscureText: false,
                    textCapitalization: TextCapitalization.none,
                    validator: (username) {
                      if (username == null || username.isEmpty) {
                        return "* Required";
                      } else if (username.length < 3) {
                        return "* Username should be at least 3 characters";
                      } else {
                        return null;
                      }
                    },
                  ),
                  InputField(
                    label: 'Full Name',
                    hintText: 'Enter your fullname',
                    constraints: constraints,
                    // enabled: !controller.loading.value,
                    controller: fullname,
                    obscureText: false,
                    textCapitalization: TextCapitalization.words,
                    validator: (fullname) {
                      if (fullname == null || fullname.isEmpty) {
                        return "* Required";
                      } else if (fullname.length < 3) {
                        return "* Fullname should be at least 3 characters";
                      } else {
                        return null;
                      }
                    },
                  ),
                  InputField(
                    label: 'Email',
                    hintText: 'Enter your email',
                    constraints: constraints,
                    obscureText: false,
                    controller: email,
                    textCapitalization: TextCapitalization.none,
                    validator: (email) {
                      String pattern =
                          r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
                      // r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                      // r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                      // r"{0,253}[a-zA-Z0-9])?)*$";
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(email!)) {
                        return 'Enter a valid email address';
                      } else if (email.isEmpty) {
                        return "* Required";
                      } else {
                        return null;
                      }
                    },
                  ),
                  InputField(
                    label: 'Affiliated Organisation',
                    hintText: 'Enter your affiliated organisation',
                    constraints: constraints,
                    // enabled: !controller.loading.value,
                    controller: affiliation,
                    obscureText: false,
                    textCapitalization: TextCapitalization.words,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "* Required";
                      } else if (value.length < 3) {
                        return "* Affiliation should be at least 3 characters";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          'Gender',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Row(
                          children: [
                            Obx(() {
                              return Radio(
                                value: 'Male',
                                groupValue:
                                    radioButtonController.selectedGender.value,
                                activeColor: const Color(0xFFA8DADC),
                                fillColor: MaterialStateProperty.all(
                                    const Color(0xFF1D3557)),
                                onChanged: (value) {
                                  radioButtonController.genderChange(value);
                                },
                              );
                            }),
                            Text(
                              'Male',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize:
                                        constraints.maxWidth < 768 ? 12 : 24,
                                  ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Obx(() {
                              return Radio(
                                value: 'Female',
                                groupValue:
                                    radioButtonController.selectedGender.value,
                                activeColor: const Color(0xFFA8DADC),
                                fillColor: MaterialStateProperty.all(
                                    const Color(0xFF1D3557)),
                                onChanged: (value) {
                                  radioButtonController.genderChange(value);
                                },
                              );
                            }),
                            Text(
                              'Female',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize:
                                        constraints.maxWidth < 768 ? 12 : 24,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  InputField(
                    label: 'Password',
                    hintText: 'Enter your password',
                    constraints: constraints,
                    // enabled: !controller.loading.value,
                    controller: password,
                    obscureText: obsecure,
                    textCapitalization: TextCapitalization.none,
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return "* Required";
                      } else if (password.length < 6) {
                        return "* Password should be at least 6 characters";
                      } else if (password.length > 15) {
                        return "* Password should not be greater than 15 characters";
                      } else {
                        return null;
                      }
                    },
                    sufIcon: IconButton(
                        icon: Icon(
                          obsecure ? Icons.visibility_off : Icons.visibility,
                          size: constraints.maxWidth < 768 ? 25 : 35,
                        ),
                        color: const Color(0xFF457B9D),
                        onPressed: () {
                          setState(() {
                            obsecure = !obsecure;
                          });
                        }),
                  ),
                  InputField(
                    label: 'Confirm Password',
                    hintText: 'Enter your confirm password',
                    constraints: constraints,
                    controller: confirmPassword,
                    obscureText: cobsecure,
                    textCapitalization: TextCapitalization.none,
                    sufIcon: IconButton(
                        icon: Icon(
                          cobsecure ? Icons.visibility_off : Icons.visibility,
                          size: constraints.maxWidth < 768 ? 25 : 35,
                        ),
                        color: const Color(0xFF457B9D),
                        onPressed: () {
                          setState(() {
                            cobsecure = !cobsecure;
                          });
                        }),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "* Required";
                      } else if (value != password.text) {
                        return "Confirm Password is not equal to Password";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: _isLoading == false
                        ? PrimaryButton(
                            text: 'Sign-up',
                            onTap: () async {
                              if (formKey!.currentState!.validate()) {
                                signup();
                              }
                            },
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: GoogleFonts.comfortaa(
                          color: const Color(0xFF457B9D),
                          fontSize: constraints.maxWidth < 768 ? 13 : 20,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('login');
                          },
                          child: Text(
                            "Login",
                            style: GoogleFonts.comfortaa(
                              color: const Color(0xFFE63946),
                              fontSize: constraints.maxWidth < 768 ? 13 : 20,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<void> signup() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(
          baseUrl +
              signupRoute +
              "?username=${username.text}&email=${email.text}&password=${password.text}&password_confirmation=${confirmPassword.text}&affiliated_with=${affiliation.text}&user_type=${_isPartener ? 'partner' : 'general'}&user_group=${_isPartener ? radioButtonController.selectedPartener.value : ''}&user_category=$representations&gender=${radioButtonController.selectedGender.value}&fullname=${fullname.text}",
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      );
      var jsonResponse = jsonDecode(response.body);

      print(response.body);
      print('------------------------------');

      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        var userData = User.fromJson(jsonResponse);

        // SharedPreferences localStorage =
        //     await SharedPreferences.getInstance();
        // localStorage.setString('token', userData.token!);
        // localStorage.setString('user', jsonEncode(userData));
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return new WelcomeScreen(
                token: userData.token,
                fullname: '${userData.data.fullname}',
              );
            },
          ),
        );

        // await Flushbar(
        //   message: "Welcome " + userData.data.fullname.toString(),
        //   icon: const Icon(
        //     Icons.info_outline,
        //     size: 28.0,
        //     color: Colors.green,
        //   ),
        //   backgroundColor: const Color(0xFF457B9D),
        //   duration: const Duration(seconds: 3),
        //   leftBarIndicatorColor: Colors.green,
        // ).show(context);
      } else {
        // RESPONSE IF STATUS IS NOT 200
        if (response.statusCode == 500) {
          setState(() {
            _isLoading = false;
          });
          await Flushbar(
            message: 'Request failed with code: ${response.statusCode}',
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
          var error = errorFromJson(response.body);
          await Flushbar(
            message: error.message,
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
    } catch (_) {
      setState(() {
        _isLoading = false;
      });
      // Navigator.of(context).pushNamed('nointernet');
      // print(
      //     'SERVER CANNOT BE REACHED AT THE MOMENT, PLEASE CHECK YOUR INTERNET AND TRY AGAIN. $_');
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
