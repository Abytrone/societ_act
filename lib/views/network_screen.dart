import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:societ_act/models/user_class.dart';
import 'package:societ_act/models/users_network_class.dart';
import 'package:societ_act/services/remote_services.dart';

class NetworkScreen extends StatefulWidget {
  const NetworkScreen({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  @override
  State<NetworkScreen> createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {
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
          'Network',
          style: GoogleFonts.comfortaa(
            color: const Color(0xFF457B9D),
            fontSize: 15,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Color(0xFFF1FAEE),
        ),
        child: StreamBuilder<List<NData>?>(
          stream: services.getPeople('', ''),
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
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 2 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: CachedNetworkImage(
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
                          ),
                          Text(
                            '@${snapshot.data![index].attributes.username}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontSize: 12),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Cases',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(fontSize: 12),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${snapshot.data![index].attributes.cases}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 20,
                                  width: 1,
                                  color: Colors.black12,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Followers',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${snapshot.data![index].attributes.followers}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              String userCase = 'user';
                              String type = 'follow';
                              services.casesAFR(
                                userCase,
                                type,
                                snapshot.data![index].id,
                                snapshot.data![index].attributes.username,
                                widget.user.token,
                                context,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0xFF1D3557),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Text(
                                'Follow',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
