import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iventas_challenge/src/common/bloc/bloc_provider.dart';
import 'package:iventas_challenge/src/common/di/dependencies_provider.dart';
import 'package:iventas_challenge/src/presentation/login/signin/bloc/signin_bloc.dart';
import 'package:iventas_challenge/src/presentation/login/signin/signin_screen.dart';
import 'package:iventas_challenge/src/presentation/users_list/bloc/users_list_bloc.dart';
import 'package:iventas_challenge/src/presentation/users_list/bloc/users_list_state.dart';
import 'package:iventas_challenge/src/presentation/users_list/iv_user_widget.dart';

final class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UsersListBloc bloc = BlocProvider.of(context);
    bloc.retrieve();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de usuarios"),
        backgroundColor: Colors.black,
        leading: null,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 20.0),
            child: GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                if (context.mounted) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      bloc: getIt<SigninBloc>(),
                      child: const SigninScreen(),
                    ),
                  ));
                }
              },
              child: const Text(
                "Cerrar sesión",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder(
          initialData: bloc.state,
          stream: bloc.observableState,
          builder: (context, snapshot) {
            final UsersListState? state = snapshot.data;
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: state?.users.length ?? 0,
                itemBuilder: ((context, index) {
                  if (state != null) {
                    return IVUserWidget(state.users[index]);
                  } else {
                    return Container();
                  }
                }));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}
