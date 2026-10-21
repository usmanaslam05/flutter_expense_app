import 'package:flutter_application/data/mappers/auth_mapper.dart';
import 'package:flutter_application/data/sources/local/auth/mock_auth_data.dart';
import 'package:flutter_application/domain/models/auth/auth_model.dart';
import 'package:flutter_application/domain/repositories/auth/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<bool> login(AuthModel authModel) async {
    // Implementation for login
    final dataAuthModel = authModel.toRemote();
    
    // Check now for user name and password for validation. Here we will call API for login and check for valid credentials.
    if(dataAuthModel.username == AuthMockData.validUser.username && dataAuthModel.password == AuthMockData.validUser.password) {
      print('Login successful for username: ${dataAuthModel.username}');
      print('$dataAuthModel');
      return await Future.value(true);
    }
    print('Login failed for username: ${dataAuthModel.username}');
    print('$dataAuthModel');
    return await Future.value(false);
  }

  @override
  Future<void> logout() async {
    // Implementation for logout
  }

  @override
  Future<bool> isLoggedIn() async {
    // Implementation for checking if user is logged in
    return false;
  }
}