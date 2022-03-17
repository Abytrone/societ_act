// ignore_for_file: constant_identifier_names
import 'dart:convert' as convert;
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:societ_act/services/remote_services.dart';
import 'package:societ_act/views/followers_screen.dart';
import 'package:societ_act/views/following_screen.dart';
import 'package:societ_act/views/network_screen.dart';
import 'package:societ_act/views/profile_screen.dart';
import '../models/user_class.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

enum ConfirmAction { CANCEL, ACCEPT }

class _NotificationScreenState extends State<NotificationScreen> {
  // Dialog box for logout
  Future<ConfirmAction?> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image.asset(
              //   'assets/caution.png',
              //   scale: 5,
              // ),
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/caution.png'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Are you sure',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              Text(
                'You want to logout of the system?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'CANCEL',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            TextButton(
              child: const Text(
                'YES',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
              onPressed: () {
                services.logout(context, token!);
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    );
  }

  RemoteServices services = RemoteServices();

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  String? token;
  User? user;

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user')!;
    token = localStorage.getString('token');
    if (userJson != '') {
      setState(() {
        var jsonResponse = convert.jsonDecode(userJson);
        user = User.fromJson(jsonResponse);
      });
      // print(user!.data.email);
    } else {
      await Flushbar(
        message: "Error loading user information.",
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

  // AppBar pop up menu actions
  void selectedItem(BuildContext context, item) {
    switch (item) {
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FollowersScreen(
                  user: user!,
                )));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FollowingScreen(
                  user: user!,
                )));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NetworkScreen(
                  user: user!,
                )));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProfileScreen(
                  user: user!,
                )));
        break;
      case 5:
        // ignore: avoid_print
        print('Settings Clicked');
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => SettingPage()));
        break;
      case 6:
        // ignore: avoid_print
        print("Privacy Clicked");
        break;
      case 7:
        // ignore: avoid_print
        print("User Logged out");
        _asyncConfirmDialog(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<int>(
            color: const Color(0xFFEDF1F4),
            icon: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.menu,
                color: Color(0xFF457B9D),
              ),
            ),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.peopleArrows,
                      color: Color(0xFF457B9D),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Followers",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.users,
                      color: Color(0xFF457B9D),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Following",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 3,
                child: Row(
                  children: [
                    const Icon(
                      Icons.people,
                      color: Color(0xFF457B9D),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Network",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 4,
                child: Row(
                  children: [
                    const Icon(
                      Icons.person,
                      color: Color(0xFF457B9D),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Profile",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 5,
                child: Row(
                  children: [
                    const Icon(
                      Icons.settings,
                      color: Color(0xFF457B9D),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Settings",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 6,
                child: Row(
                  children: [
                    const Icon(
                      Icons.privacy_tip,
                      color: Color(0xFF457B9D),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Privacy Policy",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
              const PopupMenuDivider(
                height: 10,
              ),
              PopupMenuItem<int>(
                value: 7,
                child: Row(
                  children: [
                    const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Logout",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
            ],
            onSelected: (item) => selectedItem(context, item),
          ),
        ],
        centerTitle: true,
        backgroundColor: const Color(0xFFF1FAEE),
        title: Text(
          'Notifications',
          style: GoogleFonts.comfortaa(
            color: const Color(0xFF457B9D),
            fontSize: 15,
          ),
        ),
      ),
      body: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: Color(0xFF457B9D),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    maxRadius: 20,
                    minRadius: 20,
                    backgroundColor: Colors.green,
                    backgroundImage: AssetImage(
                      'assets/vanessa-serpas-47_VDec63Mg-unsplash.jpg',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    maxRadius: 20,
                    minRadius: 20,
                    backgroundColor: Colors.green,
                    backgroundImage: AssetImage(
                      'assets/man.png',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    maxRadius: 20,
                    minRadius: 20,
                    backgroundColor: Colors.green,
                    backgroundImage: AssetImage(
                      'assets/lucas-andrade-docd4KR_f2M-unsplash.jpg',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Icon(
                        Icons.person,
                        color: Color(0xFF457B9D),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'followed you',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 12,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  '07/12/2021',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 12,
                      ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45.0, right: 10, bottom: 15),
            child: Container(
              // height: 50,
              // width: 150,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  style: BorderStyle.solid,
                  color: const Color(0xFF457B9D),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 10.0,
                          right: 10,
                        ),
                        child: CircleAvatar(
                          maxRadius: 20,
                          minRadius: 20,
                          backgroundColor: Colors.green,
                          backgroundImage: AssetImage(
                            'assets/vanessa-serpas-47_VDec63Mg-unsplash.jpg',
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Abdul Basit',
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 14,
                                    ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 9.0),
                            child: Text(
                              '@aby',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Text(
                              'Partener (Activist)',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, right: 20, left: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        style: BorderStyle.solid,
                        color: const Color(0xFF457B9D),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: const Text('Follow'),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 1.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Icon(
                        Icons.post_add_outlined,
                        color: Color(0xFF457B9D),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'followed your post',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 12,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  '07/12/2021',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 12,
                      ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10,
                ),
                child: CircleAvatar(
                  maxRadius: 20,
                  minRadius: 20,
                  backgroundColor: Colors.green,
                  backgroundImage: AssetImage(
                    'assets/vanessa-serpas-47_VDec63Mg-unsplash.jpg',
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width > 340 ? 305 : 340,
                    height: 200,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          'assets/anto-meneghini-YiaDJAjD1S0-unsplash.jpg',
                          // scale: 10,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text('View Post'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
