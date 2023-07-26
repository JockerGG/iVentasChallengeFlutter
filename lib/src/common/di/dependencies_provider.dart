import 'package:get_it/get_it.dart';
import 'package:iventas_challenge/src/presentation/counter_bloc.dart';
import 'package:iventas_challenge/src/presentation/login/bloc/login_bloc.dart';

final GetIt getIt = GetIt.instance;

void registerDependencies() {
  getIt.registerFactory(() => CounterBloc());
  getIt.registerFactory(() => LoginBloc());
}
