import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societ_act/utils/primary_button.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
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
                      'Select Location',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 20,
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
                          'Search for location',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 14,
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
                    padding: const EdgeInsets.only(
                        top: 10, left: 30, right: 30, bottom: 20),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7)),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              child: Center(
                                child: Icon(
                                  Icons.pin_drop_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Color(0xFF1D3557),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text('Use my current location'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 4),
                                child: Text(
                                  'Labadi Beach',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        color: Colors.black26,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Center(
                      child: PrimaryButton(
                        text: 'Next',
                        onTap: () {
                          Navigator.of(context).pushNamed('bottom-navy');
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
