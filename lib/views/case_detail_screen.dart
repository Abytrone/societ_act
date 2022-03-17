import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:societ_act/models/case_class.dart';
import 'package:societ_act/services/remote_services.dart';

class CasesDetailScreen extends StatefulWidget {
  const CasesDetailScreen({
    Key? key,
    required this.cases,
    required this.token,
  }) : super(key: key);
  final Info cases;
  final String token;

  @override
  _CasesDetailScreenState createState() => _CasesDetailScreenState();
}

class _CasesDetailScreenState extends State<CasesDetailScreen> {
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
          color: const Color(0xFFF1FAEE),
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
                        child: CachedNetworkImage(
                          imageUrl: widget.cases.attributes.postedBy.picture ==
                                  null
                              ? 'https://societyacts.abdulsitech.com/users/user.png'
                              : widget.cases.attributes.postedBy.picture!,
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
                        padding: const EdgeInsets.only(top: 8.0, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.cases.attributes.postedBy.fullname,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              '@${widget.cases.attributes.postedBy.username}',
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
                  // DropdownButton<String>(
                  //   // value: dropdownValue,
                  //   icon: const Icon(Icons.more_horiz),
                  //   elevation: 0,
                  //   underline: Container(),
                  //   onChanged: (String? newValue) {
                  //     setState(() {
                  //       dropdownValue = newValue!;
                  //     });
                  //   },
                  //   items: <String>['Resolve Case', 'Adopt Case']
                  //       .map<DropdownMenuItem<String>>((String value) {
                  //     return DropdownMenuItem<String>(
                  //       value: value,
                  //       child: Text(
                  //         value,
                  //         style: Theme.of(context).textTheme.bodyText2,
                  //       ),
                  //       onTap: () {
                  //         selectedItem(context, value);
                  //       },
                  //     );
                  //   }).toList(),
                  // ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  widget.cases.attributes.title,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        height: 1.3,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                ),
              ),
              CachedNetworkImage(
                imageUrl: widget.cases.attributes.picture,
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
                  widget.cases.attributes.description,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        height: 1.3,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      widget.cases.attributes.createdAt,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 12,
                            color: const Color(0xFFADADAD),
                          ),
                    ),
                  ),
                ],
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
                  LikeButton(
                    size: 20,
                    onTap: (isLiked) {
                      return services.onLikeButtonTapped(
                          isLiked, widget.cases.id, widget.token, context);
                    },
                    circleColor: const CircleColor(
                        start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    bubblesColor: const BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Color(0xff0099cc),
                    ),
                    likeBuilder: (bool isLiked) {
                      return widget.cases.attributes.like == '0'
                          ? Icon(
                              isLiked
                                  ? FontAwesomeIcons.solidHeart
                                  : FontAwesomeIcons.heart,
                              color: isLiked ? Colors.red : Colors.grey,
                              size: 20,
                            )
                          : Icon(
                              isLiked
                                  ? FontAwesomeIcons.heart
                                  : FontAwesomeIcons.solidHeart,
                              color: isLiked ? Colors.grey : Colors.red,
                              size: 20,
                            );
                    },
                    likeCount: int.parse(widget.cases.attributes.likes),
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
                      widget.cases.attributes.commentsCount,
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
                    padding: const EdgeInsets.all(8),
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
                                      fontSize: 15,
                                    ),
                            border: InputBorder.none,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                services.addComment(
                                  widget.cases.id,
                                  comment.text,
                                  widget.token,
                                  context,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF457B9D),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: const Icon(
                                  Icons.telegram,
                                  color: Colors.white,
                                  size: 30,
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
              widget.cases.attributes.comments[0].message == 'No comment'
                  ? const Center(
                      child: Text(
                        'No comments',
                      ),
                    )
                  : Flexible(
                      fit: FlexFit.loose,
                      child: ListView.builder(
                          itemCount: widget.cases.attributes.comments.length,
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
                                      child: CachedNetworkImage(
                                        imageUrl: widget.cases.attributes
                                                    .postedBy.picture ==
                                                null
                                            ? 'https://societyacts.abdulsitech.com/users/user.png'
                                            : widget.cases.attributes.postedBy
                                                .picture!,
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
                                            backgroundColor: Color.fromARGB(
                                                255, 216, 213, 213),
                                          ),
                                          baseColor: const Color(0XFFDFDFDF),
                                          highlightColor: Colors.white,
                                        ),
                                        errorWidget: (context, url, error) =>
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
                                            widget
                                                .cases
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
                                                '@${widget.cases.attributes.comments[index].user![0].username}',
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
                                      top: 10, bottom: 10, left: 60),
                                  child: Text(
                                    widget.cases.attributes.comments[index]
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
                                    widget.cases.attributes.comments[index]
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
                                        widget.cases.attributes.likes
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
