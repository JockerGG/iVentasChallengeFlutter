import 'package:flutter/material.dart';
import 'package:iventas_challenge/src/common/bloc/bloc_provider.dart';
import 'package:iventas_challenge/src/common/di/dependencies_provider.dart';
import 'package:iventas_challenge/src/common/widgets/iv_loader.dart';
import 'package:iventas_challenge/src/presentation/login/common/login_form.dart';
import 'package:iventas_challenge/src/presentation/login/signup/bloc/signup_bloc.dart';
import 'package:iventas_challenge/src/presentation/users_list/bloc/users_list_bloc.dart';
import 'package:iventas_challenge/src/presentation/users_list/users_list_screen.dart';

final class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SignupBloc bloc = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
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
                title: "Registro",
                emailError: state?.usernameError,
                passwordError: state?.passwordError,
                submitTitle: "Registrarse",
                showPassword: state?.showPassword ?? false,
                isButtonEnabled: state?.isButtonEnabled ?? false,
                toogleShowPassword: bloc.toogleShowPassword,
                onEmailChanged: bloc.usernameChange,
                onPasswordChanged: bloc.passwordChange,
                onSubmit: () async {
                  if (state?.isButtonEnabled ?? false) {
                    if (await bloc.performSignup()) {
                      if (context.mounted) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                      bloc: getIt<UsersListBloc>(),
                                      child: const UsersListScreen(),
                                    )),
                            ModalRoute.withName("/"));
                      }
                    }
                  }
                },
              ));
        },
      )),
    );
  }
}
