import 'package:flutter_application/domain/models/auth/auth_model.dart';

abstract class AuthRepo {
  Future<bool> login(AuthModel authModel, int source);
  Future<bool> register(AuthModel authModel, int source);
  Future<void> logout();
  Future<bool> isLoggedIn();
}
