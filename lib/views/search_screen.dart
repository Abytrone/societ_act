import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:societ_act/controllers/posts_controller.dart';
import 'package:societ_act/models/user_class.dart';
import 'package:societ_act/services/remote_services.dart';
import 'package:societ_act/views/post_detail_scree.dart';
import 'dart:convert' as convert;
import 'package:societ_act/views/welcom_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    _getUserInfo();

    // Timer.periodic(const Duration(seconds: 10), (timer) {
    //   _postsController.fetchPosts();
    // });
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
      case 0:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const WelcomeScreen()));
        break;
    }
  }

  final TextEditingController search = TextEditingController();
  PostsController _postsController = Get.put(PostsController());
  final RemoteServices services = RemoteServices();
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  bool adopt = false;
  String dropdownValue = '';

  Future<void> searchCase(String search) {
    return _postsController.searchPosts(search);
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
              // PopupMenuItem<int>(
              //   value: 0,
              //   child: Row(
              //     children: [
              //       const Icon(
              //         Icons.search_sharp,
              //         color: Color(0xFF457B9D),
              //       ),
              //       const SizedBox(
              //         width: 10,
              //       ),
              //       Text(
              //         "Advanced Search",
              //         style: Theme.of(context).textTheme.bodyText1!.copyWith(
              //               fontSize: 14,
              //             ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
            onSelected: (item) => selectedItem(context, item),
          ),
        ],
        centerTitle: true,
        backgroundColor: const Color(0xFFF1FAEE),
        title: Container(
          height: 37,
          width: 280,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Form(
            key: formKey,
            child: Center(
              child: TextFormField(
                controller: search,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 12),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return null;
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  label: Text(
                    'Search',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 12),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (formKey!.currentState!.validate()) {
                        searchCase(search.text);
                        print('Validated!');
                      } else {
                        print('Not Validated!');
                      }
                    },
                    icon: Icon(
                      Icons.search,
                    ),
                    color: Color(0xFF457B9D),
                    iconSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body:
          // FutureBuilder(
          //   future: searchCase(search.text),
          //   initialData: () {
          //     return Center(
          //       child: Text(
          //         'Please type something to search',
          //       ),
          //     );
          //   },
          //   builder: (context, snapshot) {
          //     switch (snapshot.connectionState) {
          //       case ConnectionState.waiting:
          //         return const Center(
          //           child: CircularProgressIndicator(color: Colors.blue),
          //         );
          //       case ConnectionState.none:
          //         return const Center(
          //           child: Text('No Posts at the moment!'),
          //         );
          //       case ConnectionState.active:
          //         return const Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       case ConnectionState.done:
          //         return snapshot.data == null
          //             ? Center(
          //                 child: Text(
          //                   'Please type something to search, or your search doesn\'t match with any post',
          //                   textAlign: TextAlign.center,
          //                 ),
          //               )
          //             :
          Obx(
        () => ListView.builder(
          itemCount: _postsController.searchList.length == 0
              ? 1
              : _postsController.searchList.length,
          itemBuilder: (BuildContext context, int index) {
            return _postsController.searchList.length == 0
                ? Container(
                    padding: const EdgeInsets.only(top: 200),
                    child: Center(
                      child: Text(
                        'Please type something to search, or your search doesn\'t match with any post',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: _postsController.searchList[index]
                                                .attributes.postedBy.picture ==
                                            'null'
                                        ? 'https://societyacts.abdulsitech.com/users/user.png'
                                        : _postsController.searchList[index]
                                            .attributes.postedBy.picture,
                                    imageBuilder: (context, image) {
                                      return CircleAvatar(
                                        maxRadius: 20,
                                        minRadius: 20,
                                        backgroundImage: image,
                                      );
                                    },
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Shimmer.fromColors(
                                      child: const CircleAvatar(
                                        maxRadius: 20,
                                        minRadius: 20,
                                        backgroundColor:
                                            Color.fromARGB(255, 216, 213, 213),
                                      ),
                                      baseColor: const Color(0XFFDFDFDF),
                                      highlightColor: Colors.white,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _postsController.searchList[index]
                                          .attributes.postedBy.fullname,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      '@${_postsController.searchList[index].attributes.postedBy.username}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontSize: 12,
                                            color: const Color(0xFF457B9D),
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (user!.data.username ==
                                _postsController.searchList[index].attributes
                                    .postedBy.username)
                              DropdownButton<String>(
                                icon: const Icon(Icons.more_horiz),
                                elevation: 0,
                                underline: Container(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                                items: <String>[
                                  'Resolve Case',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    onTap: () {
                                      _postsController.fetchPosts();
                                      String type = 'resolve';
                                      String userCase = 'case';
                                      services.casesAFR(
                                        userCase,
                                        type,
                                        _postsController.searchList[index].id,
                                        _postsController.searchList[index]
                                            .attributes.postedBy.username,
                                        token!,
                                        context,
                                      );
                                    },
                                  );
                                }).toList(),
                              )
                            else
                              DropdownButton<String>(
                                icon: const Icon(Icons.more_horiz),
                                elevation: 0,
                                underline: Container(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                                items: <String>[
                                  'Adopt Case',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    onTap: () {
                                      _postsController.fetchPosts();
                                      String type = 'adopt';
                                      String userCase = 'case';
                                      services.casesAFR(
                                        userCase,
                                        type,
                                        _postsController.searchList[index].id,
                                        _postsController.searchList[index]
                                            .attributes.postedBy.username,
                                        token!,
                                        context,
                                      );
                                    },
                                  );
                                }).toList(),
                              )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (BuildContext context, _, __) {
                                  return PostDetailScreen(
                                    posts: _postsController.searchList[index],
                                    token: token,
                                    index: _postsController.searchList.indexOf(
                                        _postsController.searchList[index]),
                                    user: user,
                                  );
                                },
                              ),
                            );
                          },
                          child: CachedNetworkImage(
                            imageUrl: _postsController
                                .searchList[index].attributes.picture,
                            imageBuilder: (context, imageProvider) => Container(
                              height: 170,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: imageProvider,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Shimmer.fromColors(
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
                                    image: AssetImage('assets/image.png'),
                                    scale: 0.7,
                                  ),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              height: 170,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                color: Color(0xFFDFDFDF),
                                image: DecorationImage(
                                  image: AssetImage('assets/no-pictures.png'),
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
                                pageBuilder: (BuildContext context, _, __) {
                                  return PostDetailScreen(
                                    posts: _postsController.searchList[index],
                                    token: token,
                                    index: _postsController.searchList.indexOf(
                                        _postsController.searchList[index]),
                                    user: user,
                                  );
                                },
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                              _postsController
                                  .searchList[index].attributes.title,
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    height: 1.3,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: Text(
                                _postsController
                                    .searchList[index].attributes.createdAt,
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
                                // _postsController.fetchPosts();
                                return services.onLikeButtonTapped(
                                  isLiked,
                                  _postsController.searchList[index].id,
                                  token!,
                                  context,
                                );
                              },
                              circleColor: const CircleColor(
                                  start: Color(0xff00ddff),
                                  end: Color(0xff0099cc)),
                              bubblesColor: const BubblesColor(
                                dotPrimaryColor: Color(0xff33b5e5),
                                dotSecondaryColor: Color(0xff0099cc),
                              ),
                              likeBuilder: (bool isLiked) {
                                return _postsController.searchList[index]
                                            .attributes.like ==
                                        '0'
                                    ? Icon(
                                        isLiked
                                            ? FontAwesomeIcons.solidHeart
                                            : FontAwesomeIcons.heart,
                                        color:
                                            isLiked ? Colors.red : Colors.grey,
                                        size: 20,
                                      )
                                    : Icon(
                                        isLiked
                                            ? FontAwesomeIcons.heart
                                            : FontAwesomeIcons.solidHeart,
                                        color:
                                            isLiked ? Colors.grey : Colors.red,
                                        size: 20,
                                      );
                              },
                              likeCount: 0,
                              countBuilder: (count, isLiked, text) {
                                var color = isLiked ? Colors.red : Colors.grey;
                                Widget result;
                                if (count == 0) {
                                  result = Text(
                                    ' ',
                                    style: TextStyle(color: color),
                                  );
                                } else {
                                  result = Text(
                                    ' ',
                                    style: TextStyle(color: color),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 1, left: 8, right: 8),
                                  child: Text(
                                    '${_postsController.searchList[index].attributes.likes} Likes',
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
                                    '${_postsController.searchList[index].attributes.commentsCount} Comments',
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
                                _postsController.searchList[index].attributes
                                    .postedBy.username)
                              Container()
                            else
                              _postsController.searchList[index].attributes
                                          .isAdopted ==
                                      '0'
                                  ? InkWell(
                                      onTap: () {
                                        _postsController.fetchPosts();
                                        String type = 'adopt';
                                        String userCase = 'case';
                                        services.casesAFR(
                                          userCase,
                                          type,
                                          _postsController.searchList[index].id,
                                          _postsController.searchList[index]
                                              .attributes.postedBy.username,
                                          token!,
                                          context,
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                            border: Border.all(
                                              color: const Color(0xFF1D3557),
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
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
          },
        ),
      ),
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
      //   },
      //   }
      // },
      // ),
    );
  }
}
