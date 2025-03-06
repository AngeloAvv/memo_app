import 'package:drift/drift.dart';
import 'package:memo_app/features/database/dao/memo/memo_dao.dart';
import 'package:memo_app/features/database/memo_database.drift.dart';
import 'package:memo_app/features/database/tables/memo/memos_table.dart';

@DriftDatabase(tables: [MemosTable], daos: [MemoDAO])
class MemoDatabase extends $MemoDatabase {
  MemoDatabase(super.executor);

  @override
  int get schemaVersion => 1;
}
