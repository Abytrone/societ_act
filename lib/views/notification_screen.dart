import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
          'Notifications',
          style: GoogleFonts.comfortaa(
            color: const Color(0xFF457B9D),
            fontSize: 15,
          ),
        ),
      ),
      body: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: Color(0xFF457B9D),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    maxRadius: 20,
                    minRadius: 20,
                    backgroundColor: Colors.green,
                    backgroundImage: AssetImage(
                      'assets/vanessa-serpas-47_VDec63Mg-unsplash.jpg',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    maxRadius: 20,
                    minRadius: 20,
                    backgroundColor: Colors.green,
                    backgroundImage: AssetImage(
                      'assets/man.png',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    maxRadius: 20,
                    minRadius: 20,
                    backgroundColor: Colors.green,
                    backgroundImage: AssetImage(
                      'assets/lucas-andrade-docd4KR_f2M-unsplash.jpg',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Icon(
                        Icons.person,
                        color: Color(0xFF457B9D),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'followed you',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 12,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  '07/12/2021',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 12,
                      ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45.0, right: 10, bottom: 15),
            child: Container(
              // height: 50,
              // width: 150,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  style: BorderStyle.solid,
                  color: const Color(0xFF457B9D),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 10.0,
                          right: 10,
                        ),
                        child: CircleAvatar(
                          maxRadius: 20,
                          minRadius: 20,
                          backgroundColor: Colors.green,
                          backgroundImage: AssetImage(
                            'assets/vanessa-serpas-47_VDec63Mg-unsplash.jpg',
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Abdul Basit',
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 14,
                                    ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 9.0),
                            child: Text(
                              '@aby',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Text(
                              'Partener (Activist)',
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
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, right: 20, left: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        style: BorderStyle.solid,
                        color: const Color(0xFF457B9D),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: const Text('Follow'),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 1.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Icon(
                        Icons.post_add_outlined,
                        color: Color(0xFF457B9D),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'followed your post',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 12,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  '07/12/2021',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 12,
                      ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10,
                ),
                child: CircleAvatar(
                  maxRadius: 20,
                  minRadius: 20,
                  backgroundColor: Colors.green,
                  backgroundImage: AssetImage(
                    'assets/vanessa-serpas-47_VDec63Mg-unsplash.jpg',
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 340,
                    height: 200,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          'assets/anto-meneghini-YiaDJAjD1S0-unsplash.jpg',
                          // scale: 10,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text('View Post'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
