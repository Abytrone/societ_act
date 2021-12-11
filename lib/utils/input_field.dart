import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      // this.icon,
      this.sufIcon,
      required this.label,
      required this.hintText,
      this.inputType,
      this.controller,
      required this.obscureText,
      required this.textCapitalization,
      // this.deco,
      this.validate,
      this.maxLines,
      this.enabled})
      : super(key: key);

  // final IconData? icon;
  final IconButton? sufIcon;
  final String label;
  final String hintText;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validate;
  final int? maxLines;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        keyboardType: inputType,
        controller: controller,
        textCapitalization: textCapitalization,
        obscureText: obscureText,
        validator: validate,
        enabled: enabled,
        decoration: InputDecoration(
          label: Text(
            label,
            style: GoogleFonts.comfortaa(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1D3557),
            ),
          ),
          hintText: hintText,
          suffixIcon: sufIcon,
        ),
        style: GoogleFonts.comfortaa(
          fontSize: 17,
          color: const Color(0xFF457B9D),
        ),
      ),
    );
  }
}
