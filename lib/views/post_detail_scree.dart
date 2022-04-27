import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:societ_act/controllers/posts_controller.dart';
import 'package:societ_act/models/posts_class.dart';
import 'package:societ_act/models/user_class.dart';
import 'package:societ_act/services/remote_services.dart';

class PostDetailScreen extends StatefulWidget {
  final Datum posts;
  final String? token;
  final User? user;
  final int index;
  const PostDetailScreen({
    Key? key,
    required this.posts,
    required this.token,
    required this.user,
    required this.index,
  }) : super(key: key);

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Timer.periodic(const Duration(seconds: 20), (timer) {
    //   _postsController.fetchPosts();
    // });
  }

  final TextEditingController comment = TextEditingController();
  final RemoteServices services = RemoteServices();
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  String dropdownValue = '';
  // AppBar pop up menu actions
  void selectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        String type = 'resolve';
        String userCase = 'case';
        services.casesAFR(userCase, type, widget.posts.id,
            widget.posts.attributes.postedBy.username, widget.token!, context);
        break;
      case 1:
        String type = 'adopt';
        String userCase = 'case';
        services.casesAFR(userCase, type, widget.posts.id,
            widget.posts.attributes.postedBy.username, widget.token!, context);
        break;
    }
  }

  PostsController _postsController = Get.put(PostsController());

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
        actions: [
          if (widget.user!.data.username ==
              widget.posts.attributes.postedBy.username)
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
                        Icons.check_circle_outline,
                        color: Color(0xFF457B9D),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Resolve Case",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add_task,
                        color: Color(0xFF457B9D),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Adopt Case",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
              onSelected: (item) => selectedItem(context, item),
            )
          else if (widget.posts.attributes.isAdopted != '1')
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
                        Icons.check_circle_outline,
                        color: Color(0xFF457B9D),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Resolve Case",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add_task,
                        color: Color(0xFF457B9D),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Adopt Case",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
              onSelected: (item) => selectedItem(context, item),
            )
          else
            Container(),
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
      backgroundColor: const Color(0xFFF1FAEE),
      body: SafeArea(
        top: false,
        left: false,
        right: false,
        child: Obx(
          () => Stack(
            children: [
              SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                                child: CachedNetworkImage(
                                  imageUrl: widget.posts.attributes.postedBy
                                              .picture ==
                                          'null'
                                      ? 'https://societyacts.abdulsitech.com/users/user.png'
                                      : widget
                                          .posts.attributes.postedBy.picture,
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
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.posts.attributes.postedBy.fullname,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
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
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          widget.posts.attributes.title,
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    height: 1.3,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                        ),
                      ),
                      CachedNetworkImage(
                        imageUrl: widget.posts.attributes.picture,
                        imageBuilder: (context, imageProvider) => Container(
                          height: 200,
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
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
                            height: 200,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
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
                          height: 200,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Color(0xFFDFDFDF),
                            image: DecorationImage(
                              image: AssetImage('assets/no-pictures.png'),
                              scale: 0.7,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          widget.posts.attributes.description,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    height: 1.3,
                                    fontSize: 15,
                                  ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      // Container(
                      //   padding: const EdgeInsets.all(8),
                      //   height: 30,
                      //   child: Expanded(
                      //     child: ListView.separated(
                      //       itemCount: 3,
                      //       separatorBuilder: (context, index) {
                      //         return Container(
                      //           width: 10,
                      //         );
                      //       },
                      //       shrinkWrap: true,
                      //       scrollDirection: Axis.horizontal,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              _postsController
                                  .postsList[widget.index].attributes.createdAt,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 12,
                                    color: const Color(0xFFADADAD),
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: SizedBox(
                          height: 1,
                          child: Container(
                            color: const Color(0xFFD7d7d7),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: LikeButton(
                              size: 20,
                              onTap: (isLiked) {
                                _postsController.fetchPosts();
                                return services.onLikeButtonTapped(
                                    isLiked,
                                    _postsController.postsList[widget.index].id,
                                    widget.token!,
                                    context);
                              },
                              circleColor: const CircleColor(
                                  start: Color(0xff00ddff),
                                  end: Color(0xff0099cc)),
                              bubblesColor: const BubblesColor(
                                dotPrimaryColor: Color(0xff33b5e5),
                                dotSecondaryColor: Color(0xff0099cc),
                              ),
                              likeBuilder: (bool isLiked) {
                                return _postsController.postsList[widget.index]
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
                              likeCount: int.parse(_postsController
                                  .postsList[widget.index].attributes.likes),
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
                                    text,
                                    style: TextStyle(color: color),
                                  );
                                }
                                return result;
                              },
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
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _postsController.postsList[widget.index]
                                  .attributes.commentsCount,
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
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: SizedBox(
                          height: 1,
                          child: Container(
                            color: const Color(0xFFD7d7d7),
                          ),
                        ),
                      ),
                      // ---------START OF COMMENTS SECTION-----------------------
                      widget.posts.attributes.comments[0].message ==
                              'No comment'
                          ? const Center(
                              child: Text(
                                'No comments',
                              ),
                            )
                          : Flexible(
                              fit: FlexFit.loose,
                              child: ListView.builder(
                                itemCount: _postsController
                                    .postsList[widget.index]
                                    .attributes
                                    .comments
                                    .length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CachedNetworkImage(
                                              imageUrl: _postsController
                                                          .postsList[
                                                              widget.index]
                                                          .attributes
                                                          .postedBy
                                                          .picture ==
                                                      'null'
                                                  ? 'https://societyacts.abdulsitech.com/users/user.png'
                                                  : _postsController
                                                      .postsList[widget.index]
                                                      .attributes
                                                      .postedBy
                                                      .picture,
                                              imageBuilder: (context, image) {
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
                                                      Color.fromARGB(
                                                          255, 216, 213, 213),
                                                ),
                                                baseColor:
                                                    const Color(0XFFDFDFDF),
                                                highlightColor: Colors.white,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
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
                                                  _postsController
                                                      .postsList[widget.index]
                                                      .attributes
                                                      .comments[index]
                                                      .user![0]
                                                      .fullname!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2,
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '@${_postsController.postsList[widget.index].attributes.comments[index].user![0].username}',
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
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 60),
                                        child: Text(
                                          _postsController
                                              .postsList[widget.index]
                                              .attributes
                                              .comments[index]
                                              .comment!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                fontSize: 15,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 60, bottom: 5),
                                        child: Text(
                                          _postsController
                                              .postsList[widget.index]
                                              .attributes
                                              .comments[index]
                                              .postedAt
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                fontSize: 12,
                                              ),
                                        ),
                                      ),
                                      // Row(
                                      //   children: [
                                      //     const Padding(
                                      //       padding: EdgeInsets.only(
                                      //           top: 8.0, bottom: 8.0, left: 60),
                                      //       child: Icon(
                                      //         FontAwesomeIcons.heart,
                                      //         color: Colors.grey,
                                      //         size: 20,
                                      //       ),
                                      //     ),
                                      //     Padding(
                                      //       padding: const EdgeInsets.all(8.0),
                                      //       child: Text(
                                      //         '0',
                                      //         style: Theme.of(context)
                                      //             .textTheme
                                      //             .bodyText2!
                                      //             .copyWith(
                                      //               fontSize: 12,
                                      //               color: Colors.grey,
                                      //             ),
                                      //       ),
                                      //     ),
                                      //     const Padding(
                                      //       padding: EdgeInsets.all(8.0),
                                      //       child: Icon(
                                      //         FontAwesomeIcons.shareAlt,
                                      //         color: Colors.grey,
                                      //         size: 20,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        child: SizedBox(
                                          height: 1,
                                          child: Container(
                                            color:
                                                Color.fromARGB(255, 92, 70, 70),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  //------------END OF COMMENTS SECTION---------------------
                ),
              ),
              Positioned(
                bottom: 0,
                height: 50,
                left: 5,
                right: 5,
                child: Form(
                  key: formKey,
                  child: Container(
                    padding: const EdgeInsets.only(top: 7),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 50,
                      controller: comment,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return null;
                        }
                        return null;
                      },
                      textCapitalization: TextCapitalization.sentences,
                      scrollPadding: const EdgeInsets.all(5),
                      decoration: InputDecoration(
                        hintText: 'Type something',
                        hintStyle: GoogleFonts.comfortaa(
                          color: Colors.black38,
                        ),
                        suffixIcon: IconButton(
                          // color: Colors.blue,
                          padding: const EdgeInsets.all(5),
                          icon: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            child: Image(
                              image: AssetImage('assets/send.png'),
                              width: 25,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            if (comment.text != '') {
                              if (formKey!.currentState!.validate()) {
                                services.addComment(widget.posts.id,
                                    comment.text, widget.token!, context);
                                _postsController.fetchPosts();
                                comment.clear();
                              }
                            }
                          },
                        ),
                        contentPadding: const EdgeInsets.all(10),
                        fillColor: Colors.white,
                        filled: true,
                        isCollapsed: true,
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
