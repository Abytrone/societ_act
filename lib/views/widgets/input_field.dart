import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    // this.icon,
    this.sufIcon,
    required this.label,
    required this.hintText,
    this.inputType,
    this.controller,
    required this.obscureText,
    required this.textCapitalization,
    // this.deco,
    this.validator,
    this.maxLines,
    this.enabled,
    required this.constraints,
  }) : super(key: key);

  // final IconData? icon;
  final IconButton? sufIcon;
  final String label;
  final String hintText;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final int? maxLines;
  final bool? enabled;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        keyboardType: inputType,
        controller: controller,
        textCapitalization: textCapitalization,
        obscureText: obscureText,
        validator: validator,
        enabled: enabled,
        decoration: InputDecoration(
          errorStyle: GoogleFonts.comfortaa(
            fontSize: constraints.maxWidth < 768 ? 12 : 17,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFE63946),
          ),
          label: Text(
            label,
            style: GoogleFonts.comfortaa(
              fontSize: constraints.maxWidth < 768 ? 15 : 25,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1D3557),
            ),
          ),
          hintText: hintText,
          suffixIcon: sufIcon,
        ),
        style: GoogleFonts.comfortaa(
          fontSize: constraints.maxWidth < 768 ? 17 : 25,
          color: const Color(0xFF457B9D),
        ),
      ),
    );
  }
}
