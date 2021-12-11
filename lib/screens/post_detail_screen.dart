import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societ_act/classes/posts_class.dart';

class PostDetailScreen extends StatefulWidget {
  final Post post;
  const PostDetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
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
        centerTitle: true,
        backgroundColor: const Color(0xFFF1FAEE),
        title: Text(
          'Post',
          style: GoogleFonts.comfortaa(
            color: const Color(0xFF457B9D),
            fontSize: 15,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: CircleAvatar(
                        maxRadius: 20,
                        minRadius: 20,
                        child: Image.network(widget.post.userImage!),
                      ),
                      // backgroundColor: Colors.blue,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.post.fullname!,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          widget.post.username!,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 12,
                                    color: const Color(0xFF457B9D),
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 110,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.more_horiz,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  widget.post.postText!,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 13,
                      ),
                ),
              ),
              Container(
                // width: 370,
                height: 200,
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      widget.post.postImage!,
                      // scale: 10,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  '02:35 05/12/2021',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 12,
                        color: const Color(0xFFADADAD),
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: SizedBox(
                  height: 1,
                  child: Container(
                    color: const Color(0xFFD7d7d7),
                  ),
                ),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      FontAwesomeIcons.heart,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 5, right: 30, left: 5),
                    child: Text(
                      widget.post.likes!,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      FontAwesomeIcons.commentAlt,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 5, right: 30, left: 5),
                    child: Text(
                      '543',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
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
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 15),
                child: SizedBox(
                  height: 1,
                  child: Container(
                    color: const Color(0xFFD7d7d7),
                  ),
                ),
              ),
              // ---------START OF COMMENTS SECTION-----------------------
              Flexible(
                fit: FlexFit.loose,
                child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  child: CircleAvatar(
                                    maxRadius: 20,
                                    minRadius: 20,
                                    child:
                                        Image.network(widget.post.userImage!),
                                  ),
                                  // backgroundColor: Colors.blue,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.post.fullname!,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          widget.post.username!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                fontSize: 12,
                                                color: const Color(0xFF457B9D),
                                              ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 18.0),
                                          child: Container(
                                            height: 20,
                                            width: 80,
                                            decoration: const BoxDecoration(
                                                color: Color(0xFF457B9D),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Center(
                                              child: Text(
                                                'Following',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                      fontSize: 10,
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 60),
                            child: Text(
                              widget.post.postText!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 13,
                                  ),
                            ),
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0, bottom: 8.0, left: 60),
                                child: Icon(
                                  FontAwesomeIcons.heart,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, bottom: 5, right: 30, left: 5),
                                child: Text(
                                  widget.post.likes!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  FontAwesomeIcons.commentAlt,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, bottom: 5, right: 30, left: 5),
                                child: Text(
                                  '543',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
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
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 15),
                            child: SizedBox(
                              height: 1,
                              child: Container(
                                color: const Color(0xFFD7d7d7),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              //------------END OF COMMENTS SECTION---------------------
            ],
          ),
        ),
      ),
    );
  }
}
