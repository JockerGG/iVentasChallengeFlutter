import 'package:get_it/get_it.dart';
import 'package:iventas_challenge/src/presentation/counter_bloc.dart';
import 'package:iventas_challenge/src/presentation/login/signin/bloc/signin_bloc.dart';
import 'package:iventas_challenge/src/presentation/login/signup/bloc/signup_bloc.dart';

final GetIt getIt = GetIt.instance;

void registerDependencies() {
  getIt.registerFactory(() => CounterBloc());
  getIt.registerFactory(() => SigninBloc());
  getIt.registerFactory(() => SignupBloc());
}
