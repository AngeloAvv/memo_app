import 'package:drift/drift.dart';

@DataClassName('MemoEntity')
class MemosTable extends Table {
  Column<int> get id => integer().autoIncrement()();

  Column<String> get title => text()();

  Column<String> get description => text()();

  Column<DateTime> get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();

  Column<DateTime> get deletedAt => dateTime().named('deleted_at').nullable()();

  @override
  String get tableName => 'memos';
}
