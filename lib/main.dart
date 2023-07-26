import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iventas_challenge/firebase_options.dart';
import 'package:iventas_challenge/src/common/bloc/bloc_provider.dart';
import 'package:iventas_challenge/src/common/di/dependencies_provider.dart'
    as di;
import 'package:iventas_challenge/src/common/di/dependencies_provider.dart';
import 'package:iventas_challenge/src/presentation/app.dart';
import 'package:iventas_challenge/src/presentation/counter_bloc.dart';
import 'package:iventas_challenge/src/presentation/counter_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.registerDependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}
