import 'package:flutter/material.dart';
import 'dart:developer' as developer;

final class IVTextfield extends StatefulWidget {
  final String hintText;
  final double height;
  final TextInputType? keyboardType;
  final String? errorText;
  final bool secureEntry;
  final bool showPassword;
  final Function(String)? onChanged;
  final Function()? toogleShowPassword;

  const IVTextfield(
      {super.key,
      required this.hintText,
      this.height = 40,
      this.keyboardType = TextInputType.text,
      this.errorText,
      this.secureEntry = false,
      this.showPassword = false,
      this.onChanged,
      this.toogleShowPassword});

  @override
  _IVTextfieldState createState() => _IVTextfieldState();
}

final class _IVTextfieldState extends State<IVTextfield> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: widget.hintText,
                  errorText: widget.errorText,
                  suffixIcon: widget.secureEntry
                      ? IconButton(
                          icon: Icon(widget.showPassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: widget.toogleShowPassword)
                      : null),
              onChanged: widget.onChanged,
              obscureText: !widget.showPassword && widget.secureEntry,
              cursorOpacityAnimates: false,
              keyboardType: widget.keyboardType),
        ),
      ],
    );
  }
}
