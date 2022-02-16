import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societ_act/utils/primary_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String category = 'Select Category';
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
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.menu,
              color: Color(0xFF457B9D),
            ),
          ),
        ],
        backgroundColor: const Color(0xFFF1FAEE),
        title: Text(
          'SocietyActs',
          style: GoogleFonts.comfortaa(
            color: const Color(0xFF457B9D),
            fontSize: 15,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              padding: const EdgeInsets.all(40),
              decoration: const BoxDecoration(
                color: Color(0xFFEDF1F4),
                // boxShadow: [
                //   BoxShadow(
                //     color: Color(0xFF616263),
                //     offset: Offset(0, -1),
                //     blurRadius: 10.0,
                //   )
                // ],
              ),
            ),
            Container(
              width: 370,
              // padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Color(0xFFF7F7F7),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF616263),
                    offset: Offset(0, -1),
                    blurRadius: 2.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 30),
                    child: Text(
                      'Welcome',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 20,
                          ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: Text(
                      'Let\'s help you setup your profile',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 15,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 45, left: 30, right: 30, bottom: 20),
                    child: DropdownButtonFormField<String>(
                      value: category,
                      icon: const Icon(
                        FontAwesomeIcons.angleDown,
                        color: Colors.black38,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Select Your Gender',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                      ),
                      iconSize: 24,
                      elevation: 0,
                      onChanged: (String? newValue) {
                        setState(() {
                          category = newValue!;
                        });
                      },
                      items: <String>[
                        'Select Category',
                        'Category 1',
                        'Category 2',
                        'Category 3',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontSize: 14),
                          ),
                        );
                      }).toList(),
                    ),
                    // TextFormField(
                    //   style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    //         fontSize: 14,
                    //       ),
                    //   decoration: InputDecoration(
                    //     label: Text(
                    //       'Select Category',
                    //       style:
                    //           Theme.of(context).textTheme.bodyText1!.copyWith(
                    //                 fontSize: 14,
                    //               ),
                    //     ),
                    //     suffixIcon: const Icon(
                    //       FontAwesomeIcons.angleDown,
                    //       color: Color(0xFF457B9D),
                    //     ),
                    //     focusColor: const Color(0xFF1D3557),
                    //     border: const OutlineInputBorder(
                    //       borderRadius: BorderRadius.all(Radius.circular(7)),
                    //     ),
                    //   ),
                    // ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: SizedBox(
                      height: 0.5,
                      // width: 300,
                      child: Container(
                        color: Colors.black38,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: Text(
                      'Type Keyword',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 17,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 30, right: 30, bottom: 20),
                    child: TextFormField(
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 14,
                          ),
                      decoration: InputDecoration(
                        label: Text(
                          'Examples: Hospitals, School Building',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 12,
                                  ),
                        ),
                        focusColor: const Color(0xFF1D3557),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Center(
                      child: PrimaryButton(
                        text: 'Next',
                        onTap: () {
                          Navigator.of(context).pushNamed('location');
                        },
                      ),
                    ),
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
