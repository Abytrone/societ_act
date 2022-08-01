import 'dart:async';
import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:new_version/new_version.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:societ_act/controllers/posts_controller.dart';
import 'package:societ_act/services/remote_services.dart';
import 'package:societ_act/views/followers_screen.dart';
import 'package:societ_act/views/following_screen.dart';
import 'package:societ_act/views/network_screen.dart';
import 'package:societ_act/views/post_detail_scree.dart';
import 'package:societ_act/views/post_upload_screen.dart';
import 'package:societ_act/views/profile_screen.dart';

import '../models/user_class.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum ConfirmAction { CANCEL, ACCEPT }

class _HomeScreenState extends State<HomeScreen> {
  final RemoteServices services = RemoteServices();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    final newVersion = NewVersion(androidId: 'com.aby.society_acts');
    advancedStatusCheck(newVersion);
  }

  advancedStatusCheck(NewVersion newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      // debugPrint(status.releaseNotes);
      // debugPrint(status.appStoreLink);
      // debugPrint(status.localVersion);
      // debugPrint(status.storeVersion);
      // debugPrint(status.canUpdate.toString());
      if (status.canUpdate == true) {
        newVersion.showUpdateDialog(
          context: context,
          versionStatus: status,
          dialogText:
              'Current version: ${status.localVersion}\nUpdate version: ${status.storeVersion}\n\n${status.releaseNotes}',
        );
      }
    }
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

  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
    return exitResult ?? false;
  }

  // ignore: unused_element
  Future<bool?> _showExitDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
  }

  AlertDialog _buildExitDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Please confirm'),
      content: const Text('Do you want to exit the app?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Yes'),
        ),
      ],
    );
  }

  // Initial Selected Value
  String dropdownValue = '';
  PostsController _postsController = Get.put(PostsController());
  bool adopt = false;
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
                // Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
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
          backgroundColor: const Color(0xFFF1FAEE),
          title: Text(
            'SocietyActs',
            style: GoogleFonts.comfortaa(
              color: const Color(0xFF457B9D),
              fontSize: 15,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                opaque: false,
                pageBuilder: (BuildContext context, _, __) {
                  return PostUploadScreen(
                    token: token,
                    user: user,
                  );
                },
              ),
            );
          },
          backgroundColor: const Color(0xFF1D3557),
          child: const Icon(
            Icons.add,
          ),
        ),
        body: Container(
          color: const Color(0xFFF1FAEE),
          child: FutureBuilder(
            future: _postsController.fetchPosts(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  );
                case ConnectionState.none:
                  return const Center(
                    child: Text('No Posts at the moment!'),
                  );
                case ConnectionState.active:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.done:
                  return RefreshIndicator(
                    onRefresh: () => _postsController.fetchPosts(),
                    child: Obx(() => ListView.builder(
                              itemCount: _postsController.postsList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CachedNetworkImage(
                                                  imageUrl: _postsController
                                                              .postsList[index]
                                                              .attributes
                                                              .postedBy
                                                              .picture ==
                                                          'null'
                                                      ? 'https://societyacts.abdulsitech.com/users/user.png'
                                                      : _postsController
                                                          .postsList[index]
                                                          .attributes
                                                          .postedBy
                                                          .picture,
                                                  imageBuilder:
                                                      (context, image) {
                                                    return CircleAvatar(
                                                      maxRadius: 20,
                                                      minRadius: 20,
                                                      backgroundImage: image,
                                                    );
                                                  },
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              downloadProgress) =>
                                                          Shimmer.fromColors(
                                                    child: const CircleAvatar(
                                                      maxRadius: 20,
                                                      minRadius: 20,
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                              216, 213, 213),
                                                    ),
                                                    baseColor:
                                                        const Color(0XFFDFDFDF),
                                                    highlightColor:
                                                        Colors.white,
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _postsController
                                                        .postsList[index]
                                                        .attributes
                                                        .postedBy
                                                        .fullname,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2,
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
                                                    '@${_postsController.postsList[index].attributes.postedBy.username}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                          fontSize: 12,
                                                          color: const Color(
                                                              0xFF457B9D),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          if (user!.data.username ==
                                              _postsController.postsList[index]
                                                  .attributes.postedBy.username)
                                            DropdownButton<String>(
                                              icon:
                                                  const Icon(Icons.more_horiz),
                                              elevation: 0,
                                              underline: Container(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  dropdownValue = newValue!;
                                                });
                                              },
                                              items: <String>[
                                                'Resolve Case',
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2,
                                                  ),
                                                  onTap: () {
                                                    _postsController
                                                        .fetchPosts();
                                                    String type = 'resolve';
                                                    String userCase = 'case';
                                                    services.casesAFR(
                                                      userCase,
                                                      type,
                                                      _postsController
                                                          .postsList[index].id,
                                                      _postsController
                                                          .postsList[index]
                                                          .attributes
                                                          .postedBy
                                                          .username,
                                                      token!,
                                                      context,
                                                    );
                                                  },
                                                );
                                              }).toList(),
                                            )
                                          else if (_postsController
                                                  .postsList[index]
                                                  .attributes
                                                  .isAdopted !=
                                              '1')
                                            DropdownButton<String>(
                                              icon:
                                                  const Icon(Icons.more_horiz),
                                              elevation: 0,
                                              underline: Container(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  dropdownValue = newValue!;
                                                });
                                              },
                                              items: <String>[
                                                'Adopt Case',
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2,
                                                  ),
                                                  onTap: () {
                                                    _postsController
                                                        .fetchPosts();
                                                    String type = 'adopt';
                                                    String userCase = 'case';
                                                    services.casesAFR(
                                                      userCase,
                                                      type,
                                                      _postsController
                                                          .postsList[index].id,
                                                      _postsController
                                                          .postsList[index]
                                                          .attributes
                                                          .postedBy
                                                          .username,
                                                      token!,
                                                      context,
                                                    );
                                                  },
                                                );
                                              }).toList(),
                                            )
                                          else
                                            Container(),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              opaque: false,
                                              pageBuilder:
                                                  (BuildContext context, _,
                                                      __) {
                                                return PostDetailScreen(
                                                  posts: _postsController
                                                      .postsList[index],
                                                  token: token,
                                                  index: _postsController
                                                      .postsList
                                                      .indexOf(_postsController
                                                          .postsList[index]),
                                                  user: user,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: CachedNetworkImage(
                                          imageUrl: _postsController
                                              .postsList[index]
                                              .attributes
                                              .picture,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            height: 170,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: imageProvider,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              Shimmer.fromColors(
                                            baseColor: const Color(0xFFDFDFDF),
                                            highlightColor: Colors.white,
                                            child: Container(
                                              height: 170,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                ),
                                                color: Color(0xFFDFDFDF),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/image.png'),
                                                  scale: 0.7,
                                                ),
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            height: 170,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                              color: Color(0xFFDFDFDF),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/no-pictures.png'),
                                                scale: 0.7,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              opaque: false,
                                              pageBuilder:
                                                  (BuildContext context, _,
                                                      __) {
                                                return PostDetailScreen(
                                                  posts: _postsController
                                                      .postsList[index],
                                                  token: token,
                                                  index: _postsController
                                                      .postsList
                                                      .indexOf(_postsController
                                                          .postsList[index]),
                                                  user: user,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Text(
                                            _postsController.postsList[index]
                                                .attributes.title,
                                            maxLines: 2,
                                            textAlign: TextAlign.left,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  height: 1.3,
                                                  fontWeight: FontWeight.bold,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: Text(
                                              _postsController.postsList[index]
                                                  .attributes.createdAt,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontSize: 12,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          LikeButton(
                                            size: 20,
                                            onTap: (isLiked) {
                                              _postsController.fetchPosts();
                                              return services
                                                  .onLikeButtonTapped(
                                                isLiked,
                                                _postsController
                                                    .postsList[index].id,
                                                token!,
                                                context,
                                              );
                                            },
                                            circleColor: const CircleColor(
                                                start: Color(0xff00ddff),
                                                end: Color(0xff0099cc)),
                                            bubblesColor: const BubblesColor(
                                              dotPrimaryColor:
                                                  Color(0xff33b5e5),
                                              dotSecondaryColor:
                                                  Color(0xff0099cc),
                                            ),
                                            likeBuilder: (bool isLiked) {
                                              return _postsController
                                                          .postsList[index]
                                                          .attributes
                                                          .like ==
                                                      '0'
                                                  ? Icon(
                                                      isLiked
                                                          ? FontAwesomeIcons
                                                              .solidHeart
                                                          : FontAwesomeIcons
                                                              .heart,
                                                      color: isLiked
                                                          ? Colors.red
                                                          : Colors.grey,
                                                      size: 20,
                                                    )
                                                  : Icon(
                                                      isLiked
                                                          ? FontAwesomeIcons
                                                              .heart
                                                          : FontAwesomeIcons
                                                              .solidHeart,
                                                      color: isLiked
                                                          ? Colors.grey
                                                          : Colors.red,
                                                      size: 20,
                                                    );
                                            },
                                            likeCount: 0,
                                            countBuilder:
                                                (count, isLiked, text) {
                                              var color = isLiked
                                                  ? Colors.red
                                                  : Colors.grey;
                                              Widget result;
                                              if (count == 0) {
                                                result = Text(
                                                  ' ',
                                                  style:
                                                      TextStyle(color: color),
                                                );
                                              } else {
                                                result = Text(
                                                  ' ',
                                                  style:
                                                      TextStyle(color: color),
                                                );
                                              }
                                              return result;
                                            },
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              FontAwesomeIcons.commentAlt,
                                              color: Colors.grey,
                                              size: 20,
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              FontAwesomeIcons.shareAlt,
                                              color: Colors.grey,
                                              size: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 1, left: 8, right: 8),
                                                child: Text(
                                                  '${_postsController.postsList[index].attributes.likes} Likes',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(
                                                        fontSize: 12,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0, left: 8, right: 8),
                                                child: Text(
                                                  '${_postsController.postsList[index].attributes.commentsCount} Comments',
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
                                          if (user!.data.username ==
                                              _postsController.postsList[index]
                                                  .attributes.postedBy.username)
                                            Container()
                                          else
                                            _postsController.postsList[index]
                                                        .attributes.isAdopted ==
                                                    '0'
                                                ? InkWell(
                                                    onTap: () {
                                                      _postsController
                                                          .fetchPosts();
                                                      String type = 'adopt';
                                                      String userCase = 'case';
                                                      services.casesAFR(
                                                        userCase,
                                                        type,
                                                        _postsController
                                                            .postsList[index]
                                                            .id,
                                                        _postsController
                                                            .postsList[index]
                                                            .attributes
                                                            .postedBy
                                                            .username,
                                                        token!,
                                                        context,
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8,
                                                                vertical: 3),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          20)),
                                                          border: Border.all(
                                                            color: const Color(
                                                                0xFF1D3557),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          'Adopt',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8,
                                                          vertical: 3),
                                                      decoration:
                                                          const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20)),
                                                        color:
                                                            Color(0xFF1D3557),
                                                      ),
                                                      child: Text(
                                                        'Adopted',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2!
                                                            .copyWith(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                        // default:
                        //   if (snapshot.hasError) {
                        //     return Center(
                        //       child: Text(
                        //         'Error getting posts: ${snapshot.error}}',
                        //         textAlign: TextAlign.center,
                        //       ),
                        //     );
                        //   } else if (snapshot.data == null) {
                        //     return const Center(
                        //       child: Text(
                        //         'No Posts Yet!',
                        //         textAlign: TextAlign.center,
                        //       ),
                        //     );
                        //   } else {
                        //     return const Center(
                        //       child: Text(
                        //         'Error Occured!',
                        //         textAlign: TextAlign.center,
                        //       ),
                        //     );
                        //   }
                        //     }
                        //   },
                        // ),
                        ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
