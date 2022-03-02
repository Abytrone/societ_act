import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:societ_act/models/user_class.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF1F4),
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              FontAwesomeIcons.angleLeft,
              color: Color(0xFF457B9D),
            ),
          ),
        ),
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.all(8.0),
        //     child: Icon(
        //       Icons.menu,
        //       color: Color(0xFF457B9D),
        //     ),
        //   ),
        // ],
        centerTitle: true,
        backgroundColor: const Color(0xFFF1FAEE),
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 15,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 170,
              padding: const EdgeInsets.all(40),
              decoration: const BoxDecoration(
                color: Color(0xFFEDF1F4),
              ),
            ),
            Container(
              width: 370,
              decoration: const BoxDecoration(
                color: Color(0xFFF7F7F7),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF616263),
                    offset: Offset(0, -1),
                    blurRadius: 2.0,
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
                          const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: CircleAvatar(
                              maxRadius: 30,
                              minRadius: 30,
                              backgroundColor: Colors.green,
                              backgroundImage: NetworkImage(
                                  // widget.user.data. ==
                                  //         'null'
                                  //     ?
                                  'https://societyacts.abdulsitech.com/users/user.png'
                                  // : snapshot
                                  //     .data![index]
                                  //     .attributes
                                  //     .postedBy
                                  //     .picture!,
                                  ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.user.data.fullname!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 17,
                                    ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                '@${widget.user.data.username}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 15,
                                      color: const Color(0xFF457B9D),
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 20),
                    child: SizedBox(
                      height: 0.5,
                      child: Container(
                        color: Colors.black38,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Text(
                                'Partner:',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15,
                                    ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                '${widget.user.data.group}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Text(
                                'Gender:',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15,
                                    ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                '${widget.user.data.gender}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Text(
                                'Email:',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15,
                                    ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                '${widget.user.data.email}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Text(
                                'Affiliated Company:',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15,
                                    ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                '${widget.user.data.affiliatedWith}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        Text(
                          '${widget.user.data.followers}',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Followers',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${widget.user.data.following}',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Following',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${widget.user.data.following}',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Adopted Cases',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: SizedBox(
                      height: 0.5,
                      child: Container(
                        color: Colors.black38,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 20),
                      child: Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.networkWired,
                            color: Color(0xFF1D3557),
                            size: 20,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Network',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 20),
                    child: Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.user,
                          color: Color(0xFF1D3557),
                          size: 20,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Account',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 20),
                    child: Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.cogs,
                          color: Color(0xFF1D3557),
                          size: 20,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Help Center',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
