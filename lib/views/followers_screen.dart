import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:societ_act/models/user_class.dart';
import 'package:societ_act/models/users_network_class.dart';
import 'package:societ_act/services/remote_services.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  RemoteServices services = RemoteServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              FontAwesomeIcons.angleLeft,
              color: Color(0xFF1D3557),
            ),
          ),
        ),
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
              //         Icons.refresh_outlined,
              //         color: Color(0xFF457B9D),
              //       ),
              //       const SizedBox(
              //         width: 10,
              //       ),
              //       Text(
              //         "Refresh",
              //         style: Theme.of(context).textTheme.bodyText1!.copyWith(
              //               fontSize: 14,
              //             ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
            // onSelected: (item) => selectedItem(context, item),
          ),
        ],
        backgroundColor: const Color(0xFFF1FAEE),
        title: Text(
          'Followers',
          style: GoogleFonts.comfortaa(
            color: const Color(0xFF457B9D),
            fontSize: 15,
          ),
        ),
      ),
      body: StreamBuilder<List<NData>?>(
        stream: services.getPeople(widget.user.data.id!, 'followers'),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            case ConnectionState.none:
              return const Center(
                child: Text('No people at the moment!'),
              );
            case ConnectionState.active:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              return Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF1FAEE),
                ),
                child: snapshot.data!.isNotEmpty
                    ? ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 5,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: CachedNetworkImage(
                                imageUrl: snapshot
                                            .data![index].attributes.picture ==
                                        'null'
                                    ? 'https://societyacts.abdulsitech.com/users/user.png'
                                    : snapshot.data![index].attributes.picture,
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
                              title: Text(
                                snapshot.data![index].attributes.fullname,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 13,
                                    ),
                              ),
                              subtitle: Text(
                                '@${snapshot.data![index].attributes.username}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 11,
                                    ),
                              ),
                              trailing: InkWell(
                                onTap: () {
                                  String type = 'follow';
                                  String userCase = 'user';
                                  services.casesAFR(
                                    userCase,
                                    type,
                                    snapshot.data![index].id,
                                    snapshot.data![index].attributes.username,
                                    widget.user.token!,
                                    context,
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Container(
                                    height: 20,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xFF457B9D)),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Center(
                                      child: Text(
                                        'Follow',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              fontSize: 10,
                                              color: const Color(0xFF457B9D),
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text('No followers at the moment!'),
                      ),
              );
          }
        },
      ),
    );
  }
}
