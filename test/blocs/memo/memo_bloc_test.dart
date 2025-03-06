import 'package:bloc_test/bloc_test.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memo_app/blocs/memo/memo_bloc.dart';
import 'package:memo_app/errors/generic_error.dart';
import 'package:memo_app/errors/repository_error.dart';
import 'package:memo_app/repositories/memo_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'memo_bloc_test.mocks.dart';

@GenerateMocks([MemoRepository])
void main() {
  late MockMemoRepository memoRepository;
  late MemoBloc bloc;

  setUp(() {
    memoRepository = MockMemoRepository();
    bloc = MemoBloc(memoRepository: memoRepository);
  });

  /// Testing the event [CreateMemoEvent]
  group('when the event CreateMemoEvent is added to the BLoC', () {
    late String title;
    late String description;

    setUp(() {
      title = faker.lorem.word();
      description = faker.lorem.sentence();
    });

    blocTest<MemoBloc, MemoState>(
      'test that MemoBloc emits MemoState.created when create is called',
      setUp: () {
        when(
          memoRepository.create(title: title, description: description),
        ).thenAnswer((_) async {});
      },
      build: () => bloc,
      act: (bloc) {
        bloc.create(title: title, description: description);
      },
      expect:
          () => <MemoState>[
            const MemoState.creating(),
            const MemoState.created(),
          ],
      verify: (_) {
        verify(memoRepository.create(title: title, description: description));
      },
    );

    blocTest<MemoBloc, MemoState>(
      'test that MemoBloc emits MemoState.errorCreating when create is called',
      setUp: () {
        when(
          memoRepository.create(title: title, description: description),
        ).thenThrow(RepositoryError(Exception()));
      },
      build: () => bloc,
      act: (bloc) {
        bloc.create(title: title, description: description);
      },
      expect:
          () => <MemoState>[
            const MemoState.creating(),
            MemoState.errorCreating(RepositoryError(Exception())),
          ],
      verify: (_) {
        verify(memoRepository.create(title: title, description: description));
      },
    );

    blocTest<MemoBloc, MemoState>(
      'test that MemoBloc emits MemoState.errorCreating(GenericError()) when create is called',
      setUp: () {
        when(
          memoRepository.create(title: title, description: description),
        ).thenThrow(Exception());
      },
      build: () => bloc,
      act: (bloc) {
        bloc.create(title: title, description: description);
      },
      expect:
          () => <MemoState>[
            const MemoState.creating(),
            MemoState.errorCreating(GenericError()),
          ],
      verify: (_) {
        verify(memoRepository.create(title: title, description: description));
      },
    );
  });

  /// Testing the event [RemoveMemoEvent]
  group('when the event RemoveMemoEvent is added to the BLoC', () {
    late int id;

    setUp(() {
      id = faker.randomGenerator.integer(999);
    });

    blocTest<MemoBloc, MemoState>(
      'test that MemoBloc emits MemoState.removed when remove is called',
      setUp: () {
        when(memoRepository.remove(id)).thenAnswer((_) async {});
      },
      build: () => bloc,
      act: (bloc) {
        bloc.remove(id);
      },
      expect:
          () => <MemoState>[
            const MemoState.removing(),
            const MemoState.removed(),
          ],
      verify: (_) {
        verify(memoRepository.remove(id));
      },
    );

    blocTest<MemoBloc, MemoState>(
      'test that MemoBloc emits MemoState.errorRemoving when remove is called',
      setUp: () {
        when(memoRepository.remove(id)).thenThrow(RepositoryError(Exception()));
      },
      build: () => bloc,
      act: (bloc) {
        bloc.remove(id);
      },
      expect:
          () => <MemoState>[
            const MemoState.removing(),
            MemoState.errorRemoving(RepositoryError(Exception())),
          ],
      verify: (_) {
        verify(memoRepository.remove(id));
      },
    );

    blocTest<MemoBloc, MemoState>(
      'test that MemoBloc emits MemoState.errorRemoving(GenericError()) when remove is called',
      setUp: () {
        when(memoRepository.remove(id)).thenThrow(Exception());
      },
      build: () => bloc,
      act: (bloc) {
        bloc.remove(id);
      },
      expect:
          () => <MemoState>[
            const MemoState.removing(),
            MemoState.errorRemoving(GenericError()),
          ],
      verify: (_) {
        verify(memoRepository.remove(id));
      },
    );
  });
}
