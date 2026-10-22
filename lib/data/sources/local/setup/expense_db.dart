import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_application/data/sources/local/dao/user/user_dao.dart';
import 'package:flutter_application/data/sources/local/setup/tables/tb_user.dart';

part 'expense_db.g.dart';


@DriftDatabase(tables: [
    Users
  ],
  daos: [
    UserDao
  ]
)
class ExpenseDb extends _$ExpenseDb {

  ExpenseDb() : super(NativeDatabase.memory(
    logStatements: true,
  ));

  @override
  int get schemaVersion => 1; 

}