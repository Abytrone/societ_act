import 'package:flutter/material.dart';
import 'package:societ_act/views/welcom_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // AppBar pop up menu actions
  void selectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const WelcomeScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_sharp,
                      color: Color(0xFF457B9D),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Advanced Search",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
            ],
            onSelected: (item) => selectedItem(context, item),
          ),
        ],
        centerTitle: true,
        backgroundColor: const Color(0xFFF1FAEE),
        title: Container(
          height: 37,
          width: 280,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
            child: TextFormField(
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 12),
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                label: Text(
                  'Search',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 12),
                ),
                suffixIcon: const Icon(
                  Icons.search,
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
