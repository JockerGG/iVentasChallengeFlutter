abstract class LoginState {
  final String? username;
  final String? password;
  final bool isLoading;
  final bool showPassword;

  LoginState(this.username, this.password, this.isLoading, this.showPassword);

  factory LoginState.updateData(
          {required String? username,
          required String? password,
          required bool showPassword,
          bool isLoading = false}) =>
      UpdateLoginDataState(
          username: username,
          password: password,
          isLoading: isLoading,
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
      required bool isLoading,
      required bool showPassword})
      : super(username, password, isLoading, showPassword);
}

final class LoginSuccessState extends LoginState {
  final String token;

  LoginSuccessState(
      {required String? username,
      required String? password,
      required bool isLoading,
      required this.token})
      : super(username, password, isLoading, false);
}

final class LoginFailState extends LoginState {
  final String message;

  LoginFailState(
      {required String? username,
      required String? password,
      required bool isLoading,
      required this.message})
      : super(username, password, isLoading, false);
}
