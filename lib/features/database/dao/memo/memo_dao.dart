import 'package:drift/drift.dart';
import 'package:memo_app/features/database/dao/memo/memo_dao.drift.dart';
import 'package:memo_app/features/database/memo_database.dart';
import 'package:memo_app/features/database/tables/memo/memos_table.dart';
import 'package:memo_app/features/database/tables/memo/memos_table.drift.dart';

@DriftAccessor(tables: [MemosTable])
class MemoDAO extends DatabaseAccessor<MemoDatabase> with $MemoDAOMixin {
  MemoDAO(super.attachedDatabase);

  Future<void> save({required String title, required String description}) =>
      into(memosTable).insert(
        MemosTableCompanion(
          title: Value(title),
          description: Value(description),
        ),
        mode: InsertMode.insertOrReplace,
      );

  Future<void> remove(int id) async {
    final query = update(memosTable);

    query.where((tbl) => tbl.id.equals(id));

    await query.write(MemosTableCompanion(deletedAt: Value(DateTime.now())));
  }

  Stream<List<MemoEntity>> fetch() {
    final query = select(memosTable);

    query.where((tbl) => tbl.deletedAt.isNull());
    query.orderBy([
      (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
    ]);

    return query.watch();
  }
}
