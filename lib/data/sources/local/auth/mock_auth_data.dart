import 'package:flutter_application/data/model/auth/auth_model.dart';

class AuthMockData {
  // Below expression is used to create a private constructor for the class. This prevents the class from being instantiated directly, and it can only be accessed through its static members.
  AuthMockData._();

  static final DataAuthModel validUser = DataAuthModel(
    username: 'testuser',
    password: 'password123',
  );
}