import 'package:flutter_application/domain/models/auth/auth_model.dart';

abstract class AuthRepo {
  Future<bool> login(AuthModel authModel);
  Future<void> logout();
  Future<bool> isLoggedIn();
}