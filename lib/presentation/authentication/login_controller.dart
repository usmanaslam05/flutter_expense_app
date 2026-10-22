import 'package:flutter_application/domain/models/auth/auth_model.dart';
import 'package:flutter_application/domain/usecases/auth/auth_use_case.dart';
import 'package:flutter_application/presentation/common/constants.dart';

class LoginController {

  // The private constructor ensures that the class cannot be instantiated from outside with keyword static and final.
  static final LoginController _instance = 
    LoginController._internal();


  // The function always provide the same instance of the class when called.
  factory LoginController() {
    return _instance;
  }

  LoginController._internal();

  final authUseCases = AuthUseCases();



  Future<bool> login(AuthModel authModel) async {
    // Implement your login logic here
    
    /* Check for empty credentials */
    if(authModel.getEmail().isEmpty || authModel.getPassword().isEmpty) {
      print('Username or password cannot be empty');
      return await Future.value(false);
    }
    print('Logging in with username: $authModel.getEmail() and password: $authModel.getPassword()');

    /* If credentials not empty, then check for valid credentials. */
    // Here we will call use case to check for valid credentials.

    return authUseCases.loginUseCase(authModel, DataSource.local); // 0 for local source, 1 for remote source.
  }
}