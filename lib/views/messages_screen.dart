import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
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
          'Messages',
          style: GoogleFonts.comfortaa(
            color: const Color(0xFF457B9D),
            fontSize: 15,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  height: 37,
                  width: 350,
                  padding: const EdgeInsets.only(top: 0, left: 10, right: 8),
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Center(
                    child: TextFormField(
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 12),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        label: Text(
                          'Search Messages',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 12),
                        ),
                        suffixIcon: const Icon(
                          FontAwesomeIcons.slidersH,
                          color: Color(0xFF457B9D),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          maxRadius: 20,
                          minRadius: 20,
                          backgroundColor: Colors.green,
                          backgroundImage: AssetImage(
                            'assets/lucas-andrade-docd4KR_f2M-unsplash.jpg',
                          ),
                        ),
                      ),
                      title: Text(
                        'Hello Aby, welcome to SocietActs.',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      subtitle: Text(
                        'To keep it very simple I have only 3 layers, I could’ve separated all the service classes',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 10,
                            ),
                      ),
                      trailing: Text(
                        '06/12/2021',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
