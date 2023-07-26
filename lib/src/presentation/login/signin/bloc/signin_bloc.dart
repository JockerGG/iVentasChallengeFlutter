import 'package:firebase_auth/firebase_auth.dart';
import 'package:iventas_challenge/src/presentation/login/common/login_bloc.dart';
import 'package:iventas_challenge/src/presentation/login/common/login_state.dart';

final class SigninBloc extends LoginBloc {
  void performSignin() async {
    changeState(LoginState.updateData(
        username: state.username,
        password: state.password,
        isLoading: true,
        showPassword: state.showPassword));
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: state.username!, password: state.password!);
      final token = await credential.user?.getIdToken();
      if (token != null) {
        changeState(LoginState.loginSuccess(token: token));
      } else {
        changeState(LoginState.loginFailed(
            username: state.username,
            password: state.password,
            message: "Ocurrió un error inesperado"));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        changeState(LoginState.loginFailed(
            username: state.username,
            password: state.password,
            message: "Usuario y/o contraseña incorrecto"));
      }
    }
  }
}
