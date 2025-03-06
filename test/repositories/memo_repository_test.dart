import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memo_app/errors/repository_error.dart';
import 'package:memo_app/features/database/dao/memo/memo_dao.dart';
import 'package:memo_app/features/database/tables/memo/memos_table.drift.dart';
import 'package:memo_app/models/memo/memo.dart';
import 'package:memo_app/repositories/mappers/memo_mapper.dart';
import 'package:memo_app/repositories/memo_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talker/talker.dart';

import '../fixtures/dto/memo_entity_fixture_factory.dart';
import '../fixtures/models/memo_fixture_factory.dart';
import 'memo_repository_test.mocks.dart';

/// Test case for the class MemoRepositoryImpl
@GenerateMocks(
  [MemoDAO, MemoMapper],
  customMocks: [
    MockSpec<Talker>(unsupportedMembers: {#configure}),
  ],
)
void main() {
  late MockMemoDAO memoDAO;
  late MockMemoMapper memoMapper;
  late MockTalker logger;

  late MemoRepository repository;

  setUp(() {
    memoDAO = MockMemoDAO();
    memoMapper = MockMemoMapper();
    logger = MockTalker();

    repository = MemoRepositoryImpl(
      memoDAO: memoDAO,
      memoMapper: memoMapper,
      logger: logger,
    );
  });

  /// Testing the method [create]
  group('when the method create is called', () {
    late String title;
    late String description;

    setUp(() {
      title = faker.lorem.word();
      description = faker.lorem.sentence();
    });

    test('create memo successfully', () async {
      when(
        memoDAO.save(title: title, description: description),
      ).thenAnswer((_) async {});

      await repository.create(title: title, description: description);

      verify(memoDAO.save(title: title, description: description));
    });

    test('create memo with unexpected error', () async {
      when(
        memoDAO.save(title: title, description: description),
      ).thenThrow(Exception());

      try {
        await repository.create(title: title, description: description);
        fail('Exception not thrown');
      } catch (error) {
        expect(error, isA<RepositoryError>());
      }

      verify(memoDAO.save(title: title, description: description));
    });
  });

  /// Testing the method [fetch]
  group('when the method fetch is called', () {
    late List<MemoEntity> entities;
    late List<Memo> memos;

    setUp(() {
      entities = MemoEntityFixture.factory().makeMany(3);
      memos = MemoFixture.factory().makeMany(3);
    });

    test('fetch memo successfully', () async {
      when(memoDAO.fetch()).thenAnswer((_) => Stream.value(entities));
      when(memoMapper.toModels(entities)).thenReturn(memos);

      final result = repository.fetch();
      await expectLater(result, emits(memos));

      verify(memoDAO.fetch());
      verify(memoMapper.toModels(entities));
    });

    test('fetch memo with DAO error', () async {
      when(memoDAO.fetch()).thenAnswer((_) => Stream.error(Exception()));

      final result = repository.fetch();
      await expectLater(result, emitsError(isA<RepositoryError>()));

      verify(memoDAO.fetch());
      verifyNever(memoMapper.toModels(entities));
    });

    test('fetch memo with mapper error', () async {
      when(memoDAO.fetch()).thenAnswer((_) => Stream.value(entities));
      when(memoMapper.toModels(entities)).thenThrow(Exception());

      final result = repository.fetch();
      await expectLater(result, emitsError(isA<RepositoryError>()));

      verify(memoDAO.fetch());
      verify(memoMapper.toModels(entities));
    });
  });

  /// Testing the method [remove]
  group('when the method remove is called', () {
    late int id;

    setUp(() {
      id = faker.guid.guid().hashCode;
    });

    test('remove memo successfully', () async {
      when(memoDAO.remove(id)).thenAnswer((_) async {});

      await repository.remove(id);

      verify(memoDAO.remove(id));
    });

    test('remove memo with unexpected error', () async {
      when(memoDAO.remove(id)).thenThrow(Exception());

      try {
        await repository.remove(id);
        fail('Exception not thrown');
      } catch (error) {
        expect(error, isA<RepositoryError>());
      }

      verify(memoDAO.remove(id));
    });
  });
}
