import 'package:drift/drift.dart';
import 'package:flutter_application/data/sources/local/setup/expense_db.dart';
import 'package:flutter_application/data/sources/local/setup/tables/tb_user.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [Users])
class UserDao extends DatabaseAccessor<ExpenseDb> with _$UserDaoMixin {
  final ExpenseDb db;

  UserDao(this.db) : super(db);

  // Create a new user
  Future<int> createUser(UsersCompanion user) {
    return into(users).insert(user);
  }

  Future<User?> getUserByUsername(String username) {
    return (select(
      users,
    )..where((tbl) => tbl.name.equals(username))).getSingleOrNull();
  }

  // Get a user by Username and Password
  Future<User?> getUserByUsernameAndPassword(String username, String password) {
    return (select(users)..where(
          (tbl) => tbl.name.equals(username) & tbl.password.equals(password),
        ))
        .getSingleOrNull();
  }
}
