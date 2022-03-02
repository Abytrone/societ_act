import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societ_act/models/posts_class.dart';
import 'package:societ_act/services/remote_services.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({
    Key? key,
    required this.posts,
    required this.token,
  }) : super(key: key);
  final Datum posts;
  final String? token;

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final TextEditingController comment = TextEditingController();
  final RemoteServices services = RemoteServices();
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          maxRadius: 20,
                          minRadius: 20,
                          backgroundImage: NetworkImage(
                            widget.posts.attributes.postedBy.picture!,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.posts.attributes.postedBy.fullname,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              '@${widget.posts.attributes.postedBy.username}',
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
                      ),
                    ],
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
                padding: const EdgeInsets.all(8),
                child: Text(
                  widget.posts.attributes.title,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                ),
              ),
              Container(
                height: 200,
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      widget.posts.attributes.picture,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  widget.posts.attributes.description,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 13,
                      ),
                  textAlign: TextAlign.justify,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8),
              //   child: Expanded(
              //     child: ListView.builder(
              //       itemCount: 3,
              //       shrinkWrap: true,
              //       scrollDirection: Axis.vertical,
              //       itemBuilder: (BuildContext context, index) {
              //         return Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Container(
              //             padding: const EdgeInsets.symmetric(
              //                 horizontal: 8, vertical: 3),
              //             decoration: BoxDecoration(
              //               borderRadius:
              //                   const BorderRadius.all(Radius.circular(20)),
              //               border: Border.all(
              //                 color: const Color(0xFF1D3557),
              //               ),
              //             ),
              //             child: Text(
              //               'Keywords',
              //               style:
              //                   Theme.of(context).textTheme.bodyText2!.copyWith(
              //                         fontSize: 12,
              //                       ),
              //             ),
              //           ),
              //         );
              //       },
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  '${widget.posts.attributes.createdAt}',
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
                      widget.posts.attributes.likes.toString(),
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
                      widget.posts.attributes.commentsCount.toString(),
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
              // Comment form
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF457B9D),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null) {
                              return '* Please type some text before you post';
                            } else {
                              return null;
                            }
                          },
                          controller: comment,
                          maxLines: 3,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            hintText:
                                'You can share your comments here...\n\n\n',
                            hintStyle:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 17,
                                    ),
                            border: InputBorder.none,
                          ),
                        ),
                        const Divider(
                          height: 10,
                          color: Color.fromARGB(255, 87, 87, 87),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                services.addComment(
                                  widget.posts.id,
                                  comment.text,
                                  widget.token!,
                                  context,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF457B9D),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Text(
                                  'Comment',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // ---------START OF COMMENTS SECTION-----------------------
              widget.posts.attributes.comments[0].message == 'No comment'
                  ? const Center(
                      child: Text(
                        'No comments',
                      ),
                    )
                  : Flexible(
                      fit: FlexFit.loose,
                      child: ListView.builder(
                          itemCount: widget.posts.attributes.comments.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        maxRadius: 20,
                                        minRadius: 20,
                                        backgroundColor: Colors.green,
                                        backgroundImage: NetworkImage(
                                          widget.posts.attributes.postedBy
                                              .picture!,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget
                                                .posts
                                                .attributes
                                                .comments[index]
                                                .user![0]
                                                .fullname!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '@${widget.posts.attributes.comments[index].user![0].username}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                      fontSize: 12,
                                                      color: const Color(
                                                          0xFF457B9D),
                                                    ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 18.0),
                                                child: Container(
                                                  height: 20,
                                                  width: 80,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              Color(0xFF457B9D),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
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
                                    widget.posts.attributes.comments[index]
                                        .comment!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 13,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 60, top: 20, bottom: 10),
                                  child: Text(
                                    widget.posts.attributes.comments[index]
                                        .createdAt
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontSize: 12,
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
                                          top: 5,
                                          bottom: 5,
                                          right: 30,
                                          left: 5),
                                      child: Text(
                                        widget.posts.attributes.likes
                                            .toString(),
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
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 15),
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
