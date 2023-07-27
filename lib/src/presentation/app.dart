import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iventas_challenge/src/common/bloc/bloc_provider.dart';
import 'package:iventas_challenge/src/common/di/dependencies_provider.dart';
import 'package:iventas_challenge/src/presentation/login/signin/bloc/signin_bloc.dart';
import 'package:iventas_challenge/src/presentation/login/signin/signin_screen.dart';
import 'package:iventas_challenge/src/presentation/users_list/users_list_screen.dart';

final class App extends StatelessWidget {
  const App({super.key});

  Widget getHomeComponent() {
    if (FirebaseAuth.instance.currentUser != null) {
      return const UsersListScreen();
    } else {
      return SigninScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    log("App started!");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "iVentasChallenge",
      theme: ThemeData(primarySwatch: Colors.blue, canvasColor: Colors.grey),
      home: BlocProvider(
        bloc: getIt<SigninBloc>(),
        child: getHomeComponent(),
      ),
    );
  }
}
