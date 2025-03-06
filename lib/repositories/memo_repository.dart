import 'package:memo_app/features/database/dao/memo/memo_dao.dart';
import 'package:memo_app/models/memo/memo.dart';
import 'package:memo_app/repositories/mappers/memo_mapper.dart';
import 'package:memo_app/repositories/repository.dart';

/// Abstract class of MemoRepository
abstract interface class MemoRepository {
  Future<void> create({required String title, required String description});

  Stream<List<Memo>> fetch();

  Future<void> remove(int id);
}

/// Implementation of the base interface MemoRepository
class MemoRepositoryImpl extends Repository implements MemoRepository {
  final MemoDAO memoDAO;
  final MemoMapper memoMapper;

  const MemoRepositoryImpl({
    required this.memoDAO,
    required this.memoMapper,
    required super.logger,
  });

  @override
  Future<void> create({required String title, required String description}) =>
      safeCode(() async {
        try {
          logger.info('[$MemoRepository] Creating memo with title: $title');

          await memoDAO.save(title: title, description: description);

          logger.info('[$MemoRepository] Memo created!');
        } catch (error, stackTrace) {
          logger.error(
            '[$MemoRepository] Error creating memo',
            error,
            stackTrace,
          );
          rethrow;
        }
      });

  @override
  Stream<List<Memo>> fetch() {
    logger.info('[$MemoRepository] Fetching memos from database');

    final entities = memoDAO.fetch();

    return entities.map((entity) {
      logger.info('[$MemoRepository] Mapping entities to models');

      return memoMapper.toModels(entity);
    }).safeCode();
  }

  @override
  Future<void> remove(int id) => safeCode(() async {
    try {
      logger.info('[$MemoRepository] Removing memo with id: $id');

      await memoDAO.remove(id);

      logger.info('[$MemoRepository] Memo removed!');
    } catch (error, stackTrace) {
      logger.error('[$MemoRepository] Error removing memo', error, stackTrace);
      rethrow;
    }
  });
}
