import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societ_act/controllers/posts_controller.dart';
import 'package:societ_act/views/post_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostsController _postsController = Get.put(PostsController());
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
      body: Container(
        color: Colors.black12,
        child: Obx(() {
          if (_postsController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: _postsController.postList.length,
              itemBuilder: (BuildContext context, int index) {
                if (_postsController.postList.isEmpty) {
                  return const Center(
                    child: Text('NO DATA!'),
                  );
                } else {
                  // ignore: avoid_print
                  // print(_postsController.postList);
                  return Container(
                    height: 300,
                    width: 400,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                maxRadius: 20,
                                minRadius: 20,
                                backgroundColor: Colors.green,
                                backgroundImage: NetworkImage(
                                  _postsController.postList[index].imageUrl!,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Abdul-Basit Yahaya',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  '@abytrone',
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
                            const SizedBox(
                              width: 110,
                            ),
                            const Icon(
                              Icons.more_horiz,
                            ),
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
                                      post: _postsController.postList[index]);
                                },
                              ),
                            );
                          },
                          child: Container(
                            // width: 400,
                            height: 170,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                // scale: 5,
                                image: NetworkImage(
                                  _postsController.postList[index].imageUrl!,
                                  // scale: 10,
                                ),
                              ),
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
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 1, left: 8, right: 8),
                              child: Text(
                                _postsController.postList[index].likes!
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
                                'View all comments',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 12,
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
            );
          }
        }),
      ),
    );
  }
}
