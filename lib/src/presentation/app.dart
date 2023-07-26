import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iventas_challenge/src/common/bloc/bloc_provider.dart';
import 'package:iventas_challenge/src/common/di/dependencies_provider.dart';
import 'package:iventas_challenge/src/presentation/login/bloc/login_bloc.dart';
import 'package:iventas_challenge/src/presentation/login/login_screen.dart';

final class App extends StatelessWidget {
  const App({super.key});

  Widget getHomeComponent() {
    if (FirebaseAuth.instance.currentUser != null) {
      return const Text("Logged");
    } else {
      return LoginScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "iVentasChallenge",
      theme: ThemeData(primarySwatch: Colors.blue, canvasColor: Colors.grey),
      home: BlocProvider(
        blocs: [() => getIt<LoginBloc>()],
        child: getHomeComponent(),
      ),
    );
  }
}
