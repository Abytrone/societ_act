import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({Key? key, required this.text, required this.onTap})
      : super(key: key);
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 300,
          height: 60,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Color(0xFF1D3557),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.comfortaa(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
