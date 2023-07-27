import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iventas_challenge/src/common/bloc/bloc_provider.dart';
import 'package:iventas_challenge/src/common/di/dependencies_provider.dart';
import 'package:iventas_challenge/src/presentation/login/signin/bloc/signin_bloc.dart';
import 'package:iventas_challenge/src/presentation/login/signin/signin_screen.dart';
import 'package:iventas_challenge/src/presentation/users_list/bloc/users_list_bloc.dart';
import 'package:iventas_challenge/src/presentation/users_list/users_list_screen.dart';

final class App extends StatelessWidget {
  const App({super.key});

  Widget getHomeComponent() {
    if (FirebaseAuth.instance.currentUser != null) {
      return BlocProvider(
        bloc: getIt<UsersListBloc>(),
        child: const UsersListScreen(),
      );
    } else {
      return BlocProvider(
        bloc: getIt<SigninBloc>(),
        child: const SigninScreen(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    log("App started!");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "iVentasChallenge",
      theme: ThemeData(primarySwatch: Colors.blue, canvasColor: Colors.grey),
      home: getHomeComponent(),
    );
  }
}
