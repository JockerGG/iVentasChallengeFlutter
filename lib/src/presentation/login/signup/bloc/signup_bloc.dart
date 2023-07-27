import 'package:firebase_auth/firebase_auth.dart';
import 'package:iventas_challenge/src/presentation/login/common/login_bloc.dart';
import 'package:iventas_challenge/src/presentation/login/common/login_state.dart';

final class SignupBloc extends LoginBloc {
  Future<bool> performSignup() async {
    changeState(LoginState.updateData(
        username: state.username,
        password: state.password,
        usernameError: null,
        passwordError: null,
        isLoading: true,
        showPassword: state.showPassword,
        isButtonEnabled: false));

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
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
      String message = "Ocurrio un error inesperado.";
      if (e.code == 'weak-password') {
        message = "La contraseña ingresada es débil.";
      } else if (e.code == 'email-already-in-use') {
        message = "Ya existe una cuenta registrada para ese correo.";
      }
      changeState(LoginState.loginFailed(
          username: state.username,
          password: state.password,
          message: message));
      return false;
    }
  }
}
