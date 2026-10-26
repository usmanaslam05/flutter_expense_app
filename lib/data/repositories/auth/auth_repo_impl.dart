import 'package:drift/drift.dart';
import 'package:flutter_application/data/mappers/auth_mapper.dart';
import 'package:flutter_application/data/sources/local/dao/user/user_dao.dart';
import 'package:flutter_application/data/sources/local/setup/expense_db.dart';
import 'package:flutter_application/data/utils/Constants.dart';
import 'package:flutter_application/domain/models/auth/auth_model.dart';
import 'package:flutter_application/domain/repositories/auth/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<bool> login(AuthModel authModel, int source) async {
    // Implementation for login
    final dataAuthModel = authModel.toRemote();
    
    if(source == DataConstants.local) {
      // Here we will check for user and password locally.

      final UserDao userDao = UserDao(ExpenseDb());


      // Get the user from local database.
      await userDao.createUser(
        UsersCompanion(
          name: Value(dataAuthModel.username),
          email: Value(dataAuthModel.username + '@example.com'),
          password: Value(dataAuthModel.password),
        )
      );

      final fetchedUser = (await userDao.getUserByUsernameAndPassword(dataAuthModel.username, 
      dataAuthModel.password))?.toData();


      print("Fetched user from local database: $fetchedUser");


      // Check if the user exists and validate the password.
      if(fetchedUser != null && 
        fetchedUser.username == dataAuthModel.username && 
        fetchedUser.password == dataAuthModel.password) {
          print('Login successful for username: ${dataAuthModel.username}');
          print('$dataAuthModel');
          return await Future.value(true);
        }
        print('Login failed for username: ${dataAuthModel.username}');
        print('$dataAuthModel');
        return await Future.value(false);
      
    } else {
      // Check now for user name and password for validation. Here we will call API for login and check for valid credentials.
      print('Login source not supported: $source');
      return await Future.value(false);
    } 



    // if(dataAuthModel.username == AuthMockData.validUser.username && 
    //   dataAuthModel.password == AuthMockData.validUser.password) {
    //     print('Login successful for username: ${dataAuthModel.username}');
    //     print('$dataAuthModel');
    //     return await Future.value(true);
    //   }
    //   print('Login failed for username: ${dataAuthModel.username}');
    //   print('$dataAuthModel');
    //   return await Future.value(false); 

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