import 'package:flutter_application/domain/models/auth/auth_model.dart';
import 'package:flutter_application/domain/usecases/auth/auth_use_case.dart';
import 'package:flutter_application/presentation/common/constants.dart';

class RegistrationController {
  static final RegistrationController _instance =
      RegistrationController._internal();

  factory RegistrationController() {
    return _instance;
  }

  RegistrationController._internal();

  final authUseCases = AuthUseCases();

  Future<bool> register(AuthModel authModel, String confirmPassword) async {
    if (authModel.getEmail().trim().isEmpty ||
        authModel.getPassword().isEmpty ||
        authModel.getPassword() != confirmPassword) {
      return false;
    }

    final normalizedAuthModel = AuthModel(
      email: authModel.getEmail().trim(),
      password: authModel.getPassword(),
    );
    return authUseCases.registerUseCase(normalizedAuthModel, DataSource.local);
  }
}
