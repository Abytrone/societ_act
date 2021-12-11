import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societ_act/classes/posts_class.dart';
import 'package:societ_act/screens/post_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// 5TDZK3EH9BS037808
// CC: 3500
//

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          FontAwesomeIcons.angleLeft,
          color: Color(0xFF457B9D),
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
        child: ListView.builder(
          itemCount: Posts.item()!.length,
          itemBuilder: (BuildContext context, int index) {
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
                            Posts.item()![index].userImage!,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Posts.item()![index].fullname!,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            Posts.item()![index].username!,
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                            return PostDetailScreen(post: Posts.item()![index]);
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
                            Posts.item()![index].postImage!,
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
                        padding:
                            const EdgeInsets.only(top: 1, left: 8, right: 8),
                        child: Text(
                          Posts.item()![index].likes! + ' Likes',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 12,
                                  ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 1, left: 8, right: 8),
                        child: Text(
                          'View all comments',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 12,
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
    );
  }
}
