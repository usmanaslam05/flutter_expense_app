import 'package:flutter_application/data/repositories/auth/auth_repo_impl.dart';
import 'package:flutter_application/domain/models/auth/auth_model.dart';
import 'package:flutter_application/presentation/common/constants.dart';

class AuthUseCases {
  // Add your authentication use case methods here

  final AuthRepoImpl authRepoImpl;

  // The private constructor ensures that the class cannot be instantiated from outside with keyword static and final.
  static final AuthUseCases _instance = 
    AuthUseCases._internal(AuthRepoImpl());


  // The function always provide the same instance of the class when called.
  factory AuthUseCases() {
    return _instance;
  }

  AuthUseCases._internal(this.authRepoImpl);


  Future<bool> loginUseCase(AuthModel authModel, DataSource source) async {
    // Implement your login logic here
    return authRepoImpl.login(authModel, source.source);
  }

}