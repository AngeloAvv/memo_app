import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memo_app/cubits/memo/memo_cubit.dart';
import 'package:memo_app/errors/generic_error.dart';
import 'package:memo_app/errors/repository_error.dart';
import 'package:memo_app/models/memo/memo.dart';
import 'package:memo_app/repositories/memo_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/models/memo_fixture_factory.dart';
import 'memo_cubit_test.mocks.dart';

@GenerateMocks([MemoRepository])
void main() {
  late MockMemoRepository memoReason;
  late MemoCubit cubit;

  setUp(() {
    memoReason = MockMemoRepository();
    cubit = MemoCubit(memoRepository: memoReason);
  });

  /// Testing the method [fetch]
  group('when the method fetch is called', () {
    late List<Memo> memos;

    setUp(() {
      memos = MemoFixture.factory().makeMany(3);
    });

    blocTest<MemoCubit, MemoState>(
      'test that MemoCubit emits MemoState.fetched when fetch is called',
      setUp: () {
        when(memoReason.fetch()).thenAnswer((_) => Stream.value(memos));
      },
      build: () => cubit,
      act: (cubit) {
        cubit.fetch();
      },
      expect: () => <MemoState>[MemoState.fetched(memos)],
      verify: (_) {
        verify(memoReason.fetch());
      },
    );

    blocTest<MemoCubit, MemoState>(
      'test that MemoCubit emits MemoState.empty when fetch is called and no memos are found',
      setUp: () {
        when(memoReason.fetch()).thenAnswer((_) => Stream.value([]));
      },
      build: () => cubit,
      act: (cubit) {
        cubit.fetch();
      },
      expect: () => <MemoState>[const MemoState.empty()],
      verify: (_) {
        verify(memoReason.fetch());
      },
    );

    blocTest<MemoCubit, MemoState>(
      'test that MemoCubit emits MemoState.errorFetching when fetch is called and an error occurs',
      setUp: () {
        when(
          memoReason.fetch(),
        ).thenAnswer((_) => Stream.error(RepositoryError(Exception())));
      },
      build: () => cubit,
      act: (cubit) {
        cubit.fetch();
      },
      expect:
          () => <MemoState>[
            MemoState.errorFetching(RepositoryError(Exception())),
          ],
      verify: (_) {
        verify(memoReason.fetch());
      },
    );

    blocTest<MemoCubit, MemoState>(
      'test that MemoCubit emits MemoState.errorFetching(GenericError()) when fetch is called and an error occurs',
      setUp: () {
        when(memoReason.fetch()).thenAnswer((_) => Stream.error(Exception()));
      },
      build: () => cubit,
      act: (cubit) {
        cubit.fetch();
      },
      expect: () => <MemoState>[MemoState.errorFetching(GenericError())],
      verify: (_) {
        verify(memoReason.fetch());
      },
    );
  });
}
