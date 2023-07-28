import 'package:flutter/material.dart';

final class IVTextfield extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? initialText;
  final TextInputType? keyboardType;
  final String? errorText;
  final bool secureEntry;
  final bool showPassword;
  final bool enabled;
  final Function(String)? onChanged;
  final Function()? toogleShowPassword;
  final IconButton? suffixIcon;

  const IVTextfield(
      {super.key,
      required this.hintText,
      this.initialText,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.errorText,
      this.secureEntry = false,
      this.showPassword = false,
      this.enabled = true,
      this.onChanged,
      this.toogleShowPassword,
      this.suffixIcon});

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
                suffixIcon: _getSuffixIcon(widget),
              ),
              onChanged: widget.onChanged,
              controller: widget.controller,
              enabled: widget.enabled,
              obscureText: !widget.showPassword && widget.secureEntry,
              keyboardType: widget.keyboardType),
        ),
      ],
    );
  }

  Widget? _getSuffixIcon(IVTextfield textField) {
    if (textField.suffixIcon != null) {
      return textField.suffixIcon;
    }

    return textField.secureEntry
        ? IconButton(
            icon: Icon(
                widget.showPassword ? Icons.visibility : Icons.visibility_off),
            onPressed: widget.toogleShowPassword)
        : null;
  }
}
