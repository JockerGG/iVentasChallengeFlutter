import 'package:firebase_auth/firebase_auth.dart';
import 'package:iventas_challenge/src/presentation/login/common/login_bloc.dart';
import 'package:iventas_challenge/src/presentation/login/common/login_state.dart';

final class SigninBloc extends LoginBloc {
  Future<bool> performSignin() async {
    changeState(LoginState.updateData(
        username: state.username,
        password: state.password,
        usernameError: null,
        passwordError: null,
        isLoading: true,
        showPassword: state.showPassword,
        isButtonEnabled: false));
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: state.username!, password: state.password!);
      final token = await credential.user?.getIdToken();
      if (token != null) {
        return true;
      } else {
        changeState(LoginState.loginFailed(
            username: state.username,
            password: state.password,
            message: "Ocurrió un error inesperado"));
        return false;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        changeState(LoginState.loginFailed(
            username: state.username,
            password: state.password,
            message: "Usuario y/o contraseña incorrecto"));
      }

      return false;
    }
  }
}
