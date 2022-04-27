import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societ_act/models/category_class.dart';
import 'package:societ_act/services/server.dart';
import 'package:societ_act/views/location_screen.dart';
import 'package:societ_act/views/widgets/primary_button.dart';
import 'package:textfield_tags/textfield_tags.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key, required this.token, required this.fullname})
      : super(key: key);
  final String token;
  final String fullname;

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? category = '';
  int? categoryID = 0;
  List<String> keywords = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF1F4),
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
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
                        top: 20, left: 30, right: 20, bottom: 5),
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 12, top: 8, bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: DropdownSearch<Category>(
                        validator: (value) {
                          if (value == null) {
                            return '* Required';
                          } else {
                            return null;
                          }
                        },
                        errorBuilder: (BuildContext context, value, index) {
                          return Center(
                            child: Text(
                              'No Data',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                          );
                        },
                        dropdownSearchBaseStyle:
                            Theme.of(context).textTheme.bodyText1,
                        dropdownSearchDecoration: InputDecoration(
                          labelText: 'Select Category',
                          labelStyle: Theme.of(context).textTheme.bodyText1,
                          border: InputBorder.none,
                          isCollapsed: true,
                        ),
                        popupTitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Select Category',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ],
                        ),
                        popupBackgroundColor: const Color(0xFFEDF1F4),
                        dropDownButton: const Icon(
                          FontAwesomeIcons.angleDown,
                          color: Color(0xFF457B9D),
                        ),
                        showSearchBox: true,
                        mode: Mode.DIALOG,
                        onFind: (filter) async {
                          var response = await Dio().get(
                            categoryRoute,
                            options: Options(
                              headers: {
                                'Accept': '*/*',
                                'Content-Type': 'application/json',
                                'Authorization': 'Bearer ${widget.token}'
                              },
                            ),
                          );
                          var models =
                              Category.fromJsonList(response.data['data']);
                          return models;
                        },
                        onChanged: (data) {
                          setState(() {
                            category = data?.name;
                            categoryID = data?.id;
                          });
                          // print(data);
                        },
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
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: Text(
                      'Type Keywords',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 17,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 30, right: 20, bottom: 5),
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 12, top: 8, bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFieldTags(
                        initialTags: const [],
                        tagsStyler: TagsStyler(
                          tagMargin: const EdgeInsets.only(right: 4.0),
                          tagCancelIcon: const Icon(Icons.cancel,
                              size: 15.0, color: Colors.red),
                          tagCancelIconPadding:
                              const EdgeInsets.only(left: 4.0, top: 2.0),
                          tagPadding: const EdgeInsets.only(
                              top: 2.0, bottom: 4.0, left: 8.0, right: 4.0),
                          tagDecoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          tagTextStyle: const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF457B9D)),
                        ),
                        textSeparators: const [" "],
                        textFieldStyler: TextFieldStyler(
                          hintText: "Examples: Hospitals, School Building",
                          hintStyle:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 15,
                                  ),
                          helperText: "Please use only space to seperate tags",
                          helperStyle:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 12,
                                    color: Colors.red,
                                  ),
                          contentPadding:
                              const EdgeInsets.only(bottom: 5, top: 12),
                          textFieldBorder: InputBorder.none,
                          textFieldFocusedBorder: InputBorder.none,
                        ),
                        onDelete: (tag) {
                          // print('onDelete: $tag');
                          setState(() {
                            keywords.remove(tag);
                          });
                        },
                        onTag: (tag) {
                          // print('onTag: $tag');
                        },
                        validator: (tag) {
                          // print('validator: $tag');

                          if (tag == '') {
                            return "* Required";
                          } else {
                            keywords.add(tag);
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20.0),
                    child: Center(
                      child: PrimaryButton(
                        text: 'Next',
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => LocationScreen(
                                categoryID: categoryID,
                                category: category,
                                keywords: keywords,
                                token: widget.token,
                                fullname: widget.fullname,
                              ),
                            ),
                          );
                          // }
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
