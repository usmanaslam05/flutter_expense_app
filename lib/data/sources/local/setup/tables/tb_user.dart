import 'package:drift/drift.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get email => text().withLength(min: 1, max: 100)();
  TextColumn get password => text().withLength(min: 1, max: 100)();
}