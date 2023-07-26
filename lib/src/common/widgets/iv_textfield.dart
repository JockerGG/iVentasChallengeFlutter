import 'package:flutter/material.dart';

typedef FormValidator = String? Function(String?);

final class IVTextfield extends StatelessWidget {
  final String hintText;
  final bool secureEntry;
  final bool showPassword;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final FormValidator? validator;
  final Function()? toogleShowPassword;

  const IVTextfield(this.hintText, this.onChanged,
      {this.secureEntry = false,
      this.showPassword = false,
      this.keyboardType,
      this.validator,
      this.toogleShowPassword,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: hintText,
                suffixIcon: secureEntry
                    ? IconButton(
                        icon: Icon(showPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: toogleShowPassword)
                    : null),
            onChanged: onChanged,
            validator: validator,
            obscureText: !showPassword && secureEntry,
            keyboardType: keyboardType,
          ),
        )
      ],
    );
  }
}
