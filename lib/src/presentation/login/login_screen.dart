import 'package:flutter/material.dart';
import 'package:iventas_challenge/src/common/bloc/bloc_provider.dart';
import 'package:iventas_challenge/src/common/widgets/iv_loader.dart';
import 'package:iventas_challenge/src/common/widgets/iv_textfield.dart';
import 'package:iventas_challenge/src/presentation/login/bloc/login_state.dart';
import 'package:iventas_challenge/src/utils/Utils.dart';
import 'bloc/login_bloc.dart';

final class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginBloc bloc = BlocProvider.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: StreamBuilder(
        initialData: bloc.state,
        stream: bloc.observableState,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state is LoginSuccessState) {}
          return IVLoader(
              state?.isLoading ?? false,
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                      image: AssetImage('assets/iventas.png'), height: 50),
                  const SizedBox(height: 28),
                  const Text("Iniciar sesión",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 28)),
                  Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IVTextfield("Correo electrónico", bloc.usernameChange,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                            return validateEmail(value)
                                ? null
                                : "Ingresa una dirección de correo válida";
                          }),
                          IVTextfield(
                            "Contraseña",
                            bloc.passwordChange,
                            secureEntry: true,
                            showPassword: state?.showPassword ?? false,
                            toogleShowPassword: bloc.toogleShowPassword,
                            validator: (value) {
                              return (value != null && value.length >= 8)
                                  ? null
                                  : "La contraseña debe ser mayor a 8 caracteres.";
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    bloc.performLogin();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black),
                                child: const Text("Inciar sesión"),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Registrarse",
                                    style: TextStyle(color: Colors.black),
                                  ))
                            ],
                          ),
                        ],
                      ))
                ],
              ));
        },
      )),
    );
  }
}
