import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Icon(
        FontAwesomeIcons.angleLeft,
        color: Color(0xFF457B9D),
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
    );
  }
}
