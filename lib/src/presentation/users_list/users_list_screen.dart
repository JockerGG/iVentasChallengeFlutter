import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iventas_challenge/src/common/bloc/bloc_provider.dart';
import 'package:iventas_challenge/src/common/di/dependencies_provider.dart';
import 'package:iventas_challenge/src/presentation/login/signin/bloc/signin_bloc.dart';
import 'package:iventas_challenge/src/presentation/login/signin/signin_screen.dart';

final class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de usuarios"),
        leading: null,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          const Text("Bienvenido usuario nuevo"),
          TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (context.mounted) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            bloc: getIt.get<SigninBloc>(),
                            child: const SigninScreen(),
                          )));
                }
              },
              child: const Text("Cerrar sesión"))
        ],
      )),
    );
  }
}
