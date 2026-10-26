import 'package:drift/drift.dart';
import 'package:flutter_application/data/mappers/auth_mapper.dart';
import 'package:flutter_application/data/sources/local/dao/user/user_dao.dart';
import 'package:flutter_application/data/sources/local/setup/expense_db.dart';
import 'package:flutter_application/data/utils/Constants.dart';
import 'package:flutter_application/domain/models/auth/auth_model.dart';
import 'package:flutter_application/domain/repositories/auth/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ExpenseDb _database = ExpenseDb();

  @override
  Future<bool> login(AuthModel authModel, int source) async {
    final dataAuthModel = authModel.toRemote();

    if (source == DataConstants.local) {
      final UserDao userDao = UserDao(_database);
      final fetchedUser = await userDao.getUserByUsernameAndPassword(
        dataAuthModel.username,
        dataAuthModel.password,
      );

      if (fetchedUser != null &&
          fetchedUser.name == dataAuthModel.username &&
          fetchedUser.password == dataAuthModel.password) {
        print('Login successful for username: ${dataAuthModel.username}');
        return true;
      }
      print('Login failed for username: ${dataAuthModel.username}');
      return false;
    } else {
      print('Login source not supported: $source');
      return false;
    }
  }

  @override
  Future<bool> register(AuthModel authModel, int source) async {
    final dataAuthModel = authModel.toRemote();

    if (source != DataConstants.local) {
      print('Registration source not supported: $source');
      return false;
    }

    final UserDao userDao = UserDao(_database);
    if (await userDao.getUserByUsername(dataAuthModel.username) != null) {
      return false;
    }

    await userDao.createUser(
      UsersCompanion(
        name: Value(dataAuthModel.username),
        email: Value('${dataAuthModel.username}@example.com'),
        password: Value(dataAuthModel.password),
      ),
    );
    return true;
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
