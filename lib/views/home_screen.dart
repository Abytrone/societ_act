import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:societ_act/models/posts_class.dart';
import 'package:societ_act/services/remote_services.dart';
import 'package:societ_act/views/post_detail_scree.dart';
import 'package:societ_act/views/post_upload_screen.dart';

import '../models/user_class.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final PostsController _postsController = Get.put(PostsController());
  final RemoteServices services = RemoteServices();
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

  final RefreshController refreshController = RefreshController();

// AppBar pop up menu actions
  void selectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        services.fetchPosts();
        break;
    }
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
                  value: 0,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.refresh_outlined,
                        color: Color(0xFF457B9D),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Refresh",
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
          color: Colors.black12,
          child: FutureBuilder<List<Datum>?>(
            future: services.fetchPosts(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
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
                  return SmartRefresher(
                    controller: refreshController,
                    onRefresh: services.fetchPosts().obs,
                    onLoading: services.fetchPosts().obs,
                    enablePullUp: true,
                    enablePullDown: true,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text('NO DATA!'),
                          );
                        } else {
                          return Container(
                            height: 370,
                            width: 400,
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Colors.white54,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            maxRadius: 20,
                                            minRadius: 20,
                                            backgroundColor: Colors.green,
                                            backgroundImage: NetworkImage(
                                              snapshot.data![index].attributes
                                                          .postedBy.picture ==
                                                      'null'
                                                  ? 'https://societyacts.abdulsitech.com/users/user.png'
                                                  : snapshot
                                                      .data![index]
                                                      .attributes
                                                      .postedBy
                                                      .picture!,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data![index].attributes
                                                  .postedBy.fullname,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              '@${snapshot.data![index].attributes.postedBy.username}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                    fontSize: 12,
                                                    color:
                                                        const Color(0xFF457B9D),
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    DropdownButton<String>(
                                      // value: dropdownValue,
                                      icon: const Icon(Icons.more_horiz),
                                      elevation: 16,
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
                                            // print(
                                            //     '$value ${snapshot.data![index].id} from ${snapshot.data![index].attributes.postedBy.username}');
                                            services.adoptCase(
                                              snapshot.data![index].id,
                                              snapshot.data![index].attributes
                                                  .postedBy.username,
                                              token!,
                                              context,
                                            );
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        opaque: false,
                                        pageBuilder:
                                            (BuildContext context, _, __) {
                                          return PostDetailScreen(
                                            posts: snapshot.data![index],
                                            token: token,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 170,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          snapshot
                                              .data![index].attributes.picture,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    snapshot.data![index].attributes.title,
                                    maxLines: 2,
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                  ),
                                ),
                                Row(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        FontAwesomeIcons.solidHeart,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        FontAwesomeIcons.commentAlt,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ),
                                    Padding(
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
                                            snapshot.data![index].attributes
                                                    .likes
                                                    .toString() +
                                                ' Likes',
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
                                              top: 1, left: 8, right: 8),
                                          child: Text(
                                            '${snapshot.data![index].attributes.commentsCount} Comments',
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
                                    snapshot.data![index].attributes
                                                .isAdopted ==
                                            0
                                        ? InkWell(
                                            onTap: () {
                                              services.adoptCase(
                                                snapshot.data![index].id,
                                                snapshot.data![index].attributes
                                                    .postedBy.username,
                                                token!,
                                                context,
                                              );
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 3),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(20)),
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xFF1D3557),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Adopt',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(
                                                        fontSize: 12,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 3),
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                color: Color(0xFF1D3557),
                                              ),
                                              child: Text(
                                                'Adopted',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            ),
                                          ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  );
                default:
                  if (snapshot.hasError) {
                    return Text(
                      'Error getting posts: ${snapshot.error}}',
                      textAlign: TextAlign.center,
                    );
                  } else if (snapshot.data == null) {
                    return const Text(
                      'No Posts Yet!',
                      textAlign: TextAlign.center,
                    );
                  } else {
                    throw 'SERVER ERROR ';
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}
