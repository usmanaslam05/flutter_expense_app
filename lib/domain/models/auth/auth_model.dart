class AuthModel{
  final String email;
  final String password;

  AuthModel({required this.email, required this.password});

  String getEmail() {
    return email;
  }
  String getPassword() {
    return password;
  }
}