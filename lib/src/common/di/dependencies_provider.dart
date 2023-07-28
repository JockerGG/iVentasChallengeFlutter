import 'package:get_it/get_it.dart';
import 'package:iventas_challenge/src/common/repository/delete_user_repository.dart';
import 'package:iventas_challenge/src/common/repository/get_users_repository.dart';
import 'package:iventas_challenge/src/common/repository/set_user_repository.dart';
import 'package:iventas_challenge/src/common/repository/update_user_repository.dart';
import 'package:iventas_challenge/src/presentation/login/signin/bloc/signin_bloc.dart';
import 'package:iventas_challenge/src/presentation/login/signup/bloc/signup_bloc.dart';
import 'package:iventas_challenge/src/presentation/user_details/bloc/user_details_bloc.dart';
import 'package:iventas_challenge/src/presentation/users_list/bloc/users_list_bloc.dart';

final GetIt getIt = GetIt.instance;

void registerDependencies() {
  getIt.registerFactory(() => SigninBloc());
  getIt.registerFactory(() => SignupBloc());
  getIt.registerFactory(() => SetUserRepositoryImpl());
  getIt.registerFactory(() => GetUsersRepositoryImpl());
  getIt.registerFactory(() => UpdateUserRepositoryImpl());
  getIt.registerFactory(() => DeleteUserRepositoryImpl());
  getIt.registerFactory(() => UsersListBloc(getIt<GetUsersRepositoryImpl>()));
  getIt.registerFactory(() => UsersDetailsBloc(getIt<SetUserRepositoryImpl>(),
      getIt<UpdateUserRepositoryImpl>(), getIt<DeleteUserRepositoryImpl>()));
}
