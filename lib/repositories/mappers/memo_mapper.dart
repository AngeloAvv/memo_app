import 'package:dart_mapper/dart_mapper.dart';
import 'package:memo_app/features/database/tables/memo/memos_table.drift.dart';
import 'package:memo_app/models/memo/memo.dart';

part 'memo_mapper.g.dart';

@Mapper()
abstract class MemoMapper {
  const MemoMapper();

  Memo toModel(MemoEntity entity);

  List<Memo> toModels(List<MemoEntity> entities) =>
      entities.map(toModel).toList(growable: false);
}
