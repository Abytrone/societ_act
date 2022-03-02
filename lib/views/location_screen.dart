import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societ_act/models/location_class.dart';
import 'package:societ_act/services/remote_services.dart';
import 'package:societ_act/services/server.dart';
import 'package:societ_act/views/widgets/primary_button.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({
    Key? key,
    required this.categoryID,
    required this.category,
    required this.token,
    required this.keywords,
  }) : super(key: key);

  final int? categoryID;
  final String? category;
  final String token;
  final List<String> keywords;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final RemoteServices service = RemoteServices();
  String? location = '';
  int? locationID = 0;

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
      backgroundColor: const Color(0xFFEDF1F4),
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
                    child: DropdownSearch<Location>(
                      dropdownSearchDecoration: const InputDecoration(
                        labelText: 'Locations',
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                      ),
                      popupTitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Select Location',
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
                        var response = await Dio().get(locationRoute,
                            options: Options(headers: {
                              'Accept': '*/*',
                              'Content-Type': 'application/json',
                              'Authorization': 'Bearer ${widget.token}'
                            }));
                        var models =
                            Location.fromJsonList(response.data['data']);
                        return models;
                      },
                      onChanged: (data) {
                        setState(() {
                          location = data?.name;
                          locationID = data?.id;
                        });
                        // print(data);
                      },
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
                          InkWell(
                            onTap: () {
                              // getUserLocation();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(
                                    'Please select location above',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 13,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 4),
                                  child: Text(
                                    location != null
                                        ? location!
                                        : 'Select Location First',
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
                          service.fetchCases(
                            locationID.toString(),
                            widget.categoryID.toString(),
                            widget.keywords,
                            widget.token,
                            context,
                          );
                          // login();
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

  // Future<Case?> login() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   try {
  //     final result = await InternetAddress.lookup(baseUrl);
  //     if (result.isNotEmpty && result[0].address.isNotEmpty) {
  //       final response = await http.post(
  //         Uri.https(baseUrl, casesRoute, {
  //           'location': locationID.toString(),
  //           'category': widget.categoryID.toString(),
  //           'keywords': widget.keywords,
  //         }),
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Accept': 'application/json',
  //           'Authorization': 'Bearer ${widget.token}'
  //         },
  //       );

  //       if (response.statusCode == 200) {
  //         setState(() {
  //           _isLoading = false;
  //         });
  //         var jsonResponse = convert.jsonDecode(response.body);
  //         var caseData = caseFromJson(response.body);
  //         Navigator.of(context).pushReplacement(
  //           PageRouteBuilder(
  //             pageBuilder: (_, __, ___) => SearchCasesScreen(
  //               cases: caseData,
  //             ),
  //           ),
  //         );
  //         await Flushbar(
  //           message: "Search Successful!",
  //           icon: const Icon(
  //             Icons.info_outline,
  //             size: 28.0,
  //             color: Colors.green,
  //           ),
  //           backgroundColor: const Color(0xFF457B9D),
  //           duration: const Duration(seconds: 3),
  //           leftBarIndicatorColor: Colors.green,
  //         ).show(context);

  //         return caseData;
  //       } else {
  //         // RESPONSE IF STATUS IS NOT 200
  //         // print('Request failed with status: ${response.statusCode}.');
  //         await Flushbar(
  //           message: "Request failed with status: ${response.statusCode}.",
  //           icon: const Icon(
  //             Icons.info_outline,
  //             size: 28.0,
  //             color: Color(0xFFE63946),
  //           ),
  //           backgroundColor: const Color(0xFF457B9D),
  //           duration: const Duration(seconds: 3),
  //           leftBarIndicatorColor: const Color(0xFFE63946),
  //         ).show(context);
  //         setState(() {
  //           _isLoading = false;
  //         });
  //         return null;
  //       }
  //     } else {
  //       // print('ADDRESS LOOKED BUT SOMETHING BAD HAPPENED');
  //       // Navigator.of(context).pushNamed('nointernet');
  //       await Flushbar(
  //         message: "Please check your internet connection and try again",
  //         icon: const Icon(
  //           Icons.info_outline,
  //           size: 28.0,
  //           color: Color(0xFFE63946),
  //         ),
  //         backgroundColor: const Color(0xFF457B9D),
  //         duration: const Duration(seconds: 3),
  //         leftBarIndicatorColor: const Color(0xFFE63946),
  //       ).show(context);
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       return null;
  //     }
  //   } on SocketException catch (_) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     // Navigator.of(context).pushNamed('nointernet');
  //     // print(
  //     //     'SERVER CANNOT BE REACHED AT THE MOMENT, PLEASE CHECK YOUR INTERNET AND TRY AGAIN. $_');
  //     await Flushbar(
  //       message: "Please check your internet connection and try again",
  //       icon: const Icon(
  //         Icons.info_outline,
  //         size: 28.0,
  //         color: Color(0xFFE63946),
  //       ),
  //       backgroundColor: const Color(0xFF457B9D),
  //       duration: const Duration(seconds: 3),
  //       leftBarIndicatorColor: const Color(0xFFE63946),
  //     ).show(context);
  //     return null;
  //   }
  // }
}
