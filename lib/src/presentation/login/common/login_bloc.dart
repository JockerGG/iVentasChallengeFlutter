import 'package:iventas_challenge/src/common/bloc/bloc.dart';
import 'package:iventas_challenge/src/presentation/login/common/login_state.dart';
import 'package:iventas_challenge/src/utils/Utils.dart';

class LoginBloc extends Bloc<LoginState> {
  LoginBloc() {
    changeState(LoginState.updateData(
        username: null,
        password: null,
        usernameError: null,
        passwordError: null,
        showPassword: false,
        isButtonEnabled: false));
  }
  void usernameChange(String value) {
    String? validationError =
        validateEmail(value) ? null : "Ingresa un correo válido";
    bool isButtonEnabled =
        validateEmail(value) && validatePassword(state.password);
    changeState(LoginState.updateData(
        username: value,
        password: state.password,
        usernameError: validationError,
        passwordError: state.passwordError,
        showPassword: state.showPassword,
        isButtonEnabled: isButtonEnabled));
  }

  void passwordChange(String value) {
    String? validationError = validatePassword(value)
        ? null
        : "La contraseña debe tener 8 o más caracteres";
    bool isButtonEnabled =
        validateEmail(state.username) && validatePassword(value);
    changeState(LoginState.updateData(
        username: state.username,
        password: value,
        usernameError: state.usernameError,
        passwordError: validationError,
        showPassword: state.showPassword,
        isButtonEnabled: isButtonEnabled));
  }

  void toogleShowPassword() => changeState(LoginState.updateData(
      username: state.username,
      password: state.password,
      usernameError: state.usernameError,
      passwordError: state.passwordError,
      showPassword: !state.showPassword,
      isButtonEnabled: state.isButtonEnabled));
}
