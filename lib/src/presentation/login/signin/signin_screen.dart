import 'package:flutter/material.dart';
import 'package:iventas_challenge/src/common/bloc/bloc_provider.dart';
import 'package:iventas_challenge/src/common/di/dependencies_provider.dart';
import 'package:iventas_challenge/src/common/widgets/iv_loader.dart';
import 'package:iventas_challenge/src/presentation/login/common/login_form.dart';
import 'package:iventas_challenge/src/presentation/login/signup/bloc/signup_bloc.dart';
import 'package:iventas_challenge/src/presentation/login/signup/signup_screen.dart';
import 'package:iventas_challenge/src/presentation/users_list/users_list_screen.dart';
import 'bloc/signin_bloc.dart';

final class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SigninBloc bloc = BlocProvider.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: StreamBuilder(
                initialData: bloc.state,
                stream: bloc.observableState,
                builder: (context, snapshot) {
                  final state = snapshot.data;
                  return IVLoader(
                    state?.isLoading ?? false,
                    LoginForm(
                      title: "Iniciar sesión",
                      emailError: state?.usernameError,
                      passwordError: state?.passwordError,
                      submitTitle: "Iniciar sesión",
                      secondButtonTitle: "Registrarse",
                      onSecondAction: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  bloc: getIt<SignupBloc>(),
                                  child: const SignupScreen(),
                                )));
                      },
                      showPassword: state?.showPassword ?? false,
                      isButtonEnabled: state?.isButtonEnabled ?? false,
                      toogleShowPassword: bloc.toogleShowPassword,
                      onEmailChanged: bloc.usernameChange,
                      onPasswordChanged: bloc.passwordChange,
                      onSubmit: () async {
                        if (state?.isButtonEnabled ?? false) {
                          if (await bloc.performSignin()) {
                            if (context.mounted) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UsersListScreen()));
                            }
                          }
                        }
                      },
                    ),
                  );
                })));
  }
}
