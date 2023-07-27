abstract class LoginState {
  final String? username;
  final String? password;
  final String? usernameError;
  final String? passwordError;
  final bool isLoading;
  final bool showPassword;
  final bool isButtonEnabled;

  LoginState(
      this.username,
      this.password,
      this.usernameError,
      this.passwordError,
      this.isLoading,
      this.showPassword,
      this.isButtonEnabled);

  factory LoginState.updateData(
          {required String? username,
          required String? password,
          required String? usernameError,
          required String? passwordError,
          required bool showPassword,
          required bool isButtonEnabled,
          bool isLoading = false}) =>
      UpdateLoginDataState(
          username: username,
          password: password,
          usernameError: usernameError,
          passwordError: passwordError,
          isLoading: isLoading,
          isButtonEnabled: isButtonEnabled,
          showPassword: showPassword);

  factory LoginState.loginSuccess({required String token}) => LoginSuccessState(
      username: "", password: "", isLoading: false, token: token);

  factory LoginState.loginFailed(
          {required String? username,
          required String? password,
          required String message}) =>
      LoginFailState(
          username: username,
          password: password,
          isLoading: false,
          message: message);
}

final class UpdateLoginDataState extends LoginState {
  UpdateLoginDataState(
      {required String? username,
      required String? password,
      required String? usernameError,
      required String? passwordError,
      required bool isLoading,
      required bool showPassword,
      required bool isButtonEnabled})
      : super(username, password, usernameError, passwordError, isLoading,
            showPassword, isButtonEnabled);
}

final class LoginSuccessState extends LoginState {
  final String token;

  LoginSuccessState(
      {required String? username,
      required String? password,
      required bool isLoading,
      required this.token})
      : super(username, password, null, null, isLoading, false, true);
}

final class LoginFailState extends LoginState {
  final String message;

  LoginFailState(
      {required String? username,
      required String? password,
      required bool isLoading,
      required this.message})
      : super(username, password, null, null, false, false, true);
}
