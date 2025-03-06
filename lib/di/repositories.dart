part of 'dependency_injector.dart';

final List<RepositoryProvider> _repositories = [
  RepositoryProvider<MemoRepository>(
    create:
        (context) => MemoRepositoryImpl(
          memoDAO: context.read<MemoDatabase>().memoDAO,
          memoMapper: const MemoMapperImpl(),
          logger: context.read(),
        ),
  ),
];
