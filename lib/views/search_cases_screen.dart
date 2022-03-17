import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:societ_act/models/case_class.dart';
import 'package:societ_act/services/remote_services.dart';
import 'package:societ_act/views/case_detail_screen.dart';

class SearchCasesScreen extends StatefulWidget {
  const SearchCasesScreen({
    Key? key,
    required this.cases,
    required this.token,
  }) : super(key: key);
  final List<Info> cases;
  final String token;
  @override
  _SearchCasesScreenState createState() => _SearchCasesScreenState();
}

class _SearchCasesScreenState extends State<SearchCasesScreen> {
  String dropdownValue = '';
  RemoteServices services = RemoteServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('bottom-navy');
          },
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.home_outlined,
              color: Color(0xFF457B9D),
            ),
          ),
        ),
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
          itemCount: widget.cases.length,
          itemBuilder: (BuildContext context, int index) {
            if (widget.cases.isEmpty) {
              return const Center(
                child: Text('NO DATA!'),
              );
            } else {
              return Container(
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
                      offset: const Offset(0, 2), // changes position of shadow
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
                                imageUrl: widget.cases[index].attributes
                                            .postedBy.picture ==
                                        null
                                    ? 'https://societyacts.abdulsitech.com/users/user.png'
                                    : widget.cases[index].attributes.postedBy
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
                                  widget.cases[index].attributes.postedBy
                                      .fullname,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  '@${widget.cases[index].attributes.postedBy.username}',
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
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              onTap: () {
                                String type = 'adopt';
                                String userCase = 'case';
                                services.casesAFR(
                                  userCase,
                                  type,
                                  widget.cases[index].id,
                                  widget.cases[index].attributes.postedBy
                                      .username,
                                  widget.token,
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
                            pageBuilder: (BuildContext context, _, __) {
                              return CasesDetailScreen(
                                cases: widget.cases[index],
                                token: widget.token,
                              );
                            },
                          ),
                        );
                      },
                      child: CachedNetworkImage(
                        imageUrl: widget.cases[index].attributes.picture,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        widget.cases[index].attributes.title,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              height: 1.3,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Text(
                            widget.cases[index].attributes.createdAt,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
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
                            return services.onLikeButtonTapped(
                              isLiked,
                              widget.cases[index].id,
                              widget.token,
                              context,
                            );
                          },
                          circleColor: const CircleColor(
                              start: Color(0xff00ddff), end: Color(0xff0099cc)),
                          bubblesColor: const BubblesColor(
                            dotPrimaryColor: Color(0xff33b5e5),
                            dotSecondaryColor: Color(0xff0099cc),
                          ),
                          likeBuilder: (bool isLiked) {
                            return widget.cases[index].attributes.like == '0'
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
                                '${widget.cases[index].attributes.likes} Likes',
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
                                '${widget.cases[index].attributes.commentsCount} Comments',
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
                        widget.cases[index].attributes.isAdopted == '0'
                            ? InkWell(
                                onTap: () {
                                  String type = 'adopt';
                                  String userCase = 'case';
                                  services.casesAFR(
                                    userCase,
                                    type,
                                    widget.cases[index].id,
                                    widget.cases[index].attributes.postedBy
                                        .username,
                                    widget.token,
                                    context,
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
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
      ),
    );
  }
}
