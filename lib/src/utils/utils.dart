bool validateEmail(String? email) {
  return email != null &&
      email.isNotEmpty &&
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
}

bool validatePassword(String? password) {
  return password != null && password.isNotEmpty && password.length >= 8;
}
