import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aibak/Core/Utils/size_utils.dart';

import '../Theme/theme_helper.dart';

class CustomTextField extends StatefulWidget {
  final String? Function(String?)? validator;
  final TextStyle? style;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputAction? action;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Function()? onTap;
  final String label;
  bool isError;
  final String errorText;
  final double width;
  final int maxLines;
  final bool isPassword;
  final bool readOnly;
  final bool isEnabled;
  final bool isRequired;

  CustomTextField({
    super.key,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.style,
    this.action,
    this.inputFormatter,
    this.focusNode,
    this.onChanged,
    this.onTap,
    required this.label,
    this.isError = false,
    this.errorText = '',
    this.width = double.infinity,
    this.maxLines = 1,
    this.maxLength,
    this.isPassword = false,
    this.readOnly = false,
    this.isEnabled = true,
    this.isRequired = false,
  });

  @override
  State<CustomTextField> createState() => _SkTextFieldState();
}

bool passwordHidden = true;

class _SkTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    if (widget.errorText.isNotEmpty) {
      setState(() {
        widget.isError = true;
      });
    }
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            maxLength: widget.maxLength,
            validator: widget.validator,
            style: GoogleFonts.poppins(
                color: appTheme.whiteA700, fontSize: 17.fSize),
            readOnly: widget.readOnly,
            inputFormatters: widget.inputFormatter,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            focusNode: widget.focusNode,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            maxLines: widget.maxLines,
            obscureText: widget.isPassword && passwordHidden,
            decoration: InputDecoration(
              enabled: widget.isEnabled,
              labelText: widget.isRequired ? "${widget.label}*" : widget.label,
              labelStyle: GoogleFonts.poppins(
                color: widget.isError
                    ? const Color.fromRGBO(230, 57, 70, .6)
                    : appTheme.gold,
                // : Colors.grey.shade700,
              ),
              floatingLabelStyle: GoogleFonts.poppins(
                  color: widget.isError
                      ? const Color.fromRGBO(230, 57, 70, 1)
                      : appTheme.gold,
                  fontWeight: FontWeight.w400),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: appTheme.gold, width: 1.0),
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.isError
                      ? const Color.fromRGBO(230, 57, 70, 1)
                      : appTheme.gold,
                  // : Colors.grey.shade700,
                  width: 2.0,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.isError
                      ? const Color.fromRGBO(230, 57, 70, 1)
                      : appTheme.gold,
                  width: 2.0,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      padding: const EdgeInsets.only(right: 8),
                      icon: Icon(
                        passwordHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordHidden = !passwordHidden;
                        });
                      },
                    )
                  : null,
            ),
          ),
          if (widget.errorText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                widget.errorText,
                textAlign: TextAlign.right,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color.fromRGBO(230, 57, 70, 1),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
