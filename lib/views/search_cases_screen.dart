import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societ_act/models/case_class.dart';
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
          itemCount: widget.cases.length,
          itemBuilder: (BuildContext context, int index) {
            if (widget.cases.isEmpty) {
              return const Center(
                child: Text('NO DATA!'),
              );
            } else {
              return Container(
                height: 350,
                width: 400,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
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
                              child: CircleAvatar(
                                maxRadius: 20,
                                minRadius: 20,
                                backgroundColor: Colors.green,
                                backgroundImage: NetworkImage(
                                  widget.cases[index].attributes.postedBy
                                              .picture ==
                                          'null'
                                      ? 'https://societyacts.abdulsitech.com/users/user.png'
                                      : widget.cases[index].attributes.postedBy
                                          .picture!,
                                ),
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
                              return CasesDetailScreen(
                                  cases: widget.cases[index],
                                  token: widget.token);
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
                            image: NetworkImage(
                              widget.cases[index].attributes.picture,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        widget.cases[index].attributes.title,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 1, left: 8, right: 8),
                          child: Text(
                            widget.cases[index].attributes.likes.toString() +
                                ' Likes',
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
                            '${widget.cases[index].attributes.commentsCount} Comments',
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
            }
          },
        ),
      ),
    );
  }
}
