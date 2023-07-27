import 'package:flutter/material.dart';
import 'package:iventas_challenge/src/common/widgets/iv_textfield.dart';

final class LoginForm extends StatefulWidget {
  final String title;
  final String? emailError;
  final String? passwordError;
  final String submitTitle;
  final String? secondButtonTitle;
  final bool showPassword;
  final bool isButtonEnabled;
  final Function() onSubmit;
  final Function()? onSecondAction;
  final Function() toogleShowPassword;
  final Function(String) onEmailChanged;
  final Function(String) onPasswordChanged;

  const LoginForm(
      {super.key,
      required this.title,
      this.emailError,
      this.passwordError,
      required this.submitTitle,
      this.secondButtonTitle,
      required this.showPassword,
      required this.isButtonEnabled,
      required this.onSubmit,
      this.onSecondAction,
      required this.toogleShowPassword,
      required this.onEmailChanged,
      required this.onPasswordChanged});

  @override
  _LoginFormState createState() => _LoginFormState();
}

final class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(image: AssetImage('assets/iventas.png'), height: 50),
        const SizedBox(height: 28),
        Text(widget.title,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 28)),
        Form(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IVTextfield(
              hintText: "Correo electrónico",
              onChanged: widget.onEmailChanged,
              errorText: widget.emailError,
              keyboardType: TextInputType.emailAddress,
            ),
            IVTextfield(
              hintText: "Contraseña",
              onChanged: widget.onPasswordChanged,
              errorText: widget.passwordError,
              secureEntry: true,
              showPassword: widget.showPassword,
              toogleShowPassword: widget.toogleShowPassword,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: widget.onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (widget.isButtonEnabled)
                        ? Colors.black
                        : Colors.black54,
                  ),
                  child: Text(widget.submitTitle),
                )
              ],
            ),
            if (widget.secondButtonTitle != null &&
                widget.onSecondAction != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: widget.onSecondAction,
                      child: Text(
                        widget.secondButtonTitle!,
                        style: const TextStyle(color: Colors.black),
                      ))
                ],
              ),
          ],
        ))
      ],
    );
  }
}
