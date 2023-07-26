import 'package:iventas_challenge/src/common/bloc/bloc.dart';
import 'package:iventas_challenge/src/presentation/login/common/login_state.dart';

class LoginBloc extends Bloc<LoginState> {
  LoginBloc() {
    changeState(LoginState.updateData(
        username: null, password: null, showPassword: false));
  }
  void usernameChange(String value) => changeState(LoginState.updateData(
      username: value,
      password: state.password,
      showPassword: state.showPassword));

  void passwordChange(String value) => changeState(LoginState.updateData(
      username: state.username,
      password: value,
      showPassword: state.showPassword));

  void toogleShowPassword() => changeState(LoginState.updateData(
      username: state.username,
      password: state.password,
      showPassword: !state.showPassword));
}
