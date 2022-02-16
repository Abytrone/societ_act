import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
        title: Container(
          height: 37,
          width: 280,
          padding: const EdgeInsets.only(top: 0, left: 10, right: 8),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
            child: TextFormField(
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 12),
              decoration: InputDecoration(
                border: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                label: Text(
                  'Search',
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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(17.0),
                child: Text('Trending Posts'),
              ),
              const Divider(
                thickness: 2,
              ),
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    child: Text(
                      '#badroads',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 15),
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
