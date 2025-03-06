part of 'memo_cubit.dart';

@freezed
sealed class MemoState with _$MemoState {
  const factory MemoState.fetching() = FetchingMemoState;

  const factory MemoState.fetched(List<Memo> memos) = FetchedMemoState;

  const factory MemoState.empty() = EmptyMemoState;

  const factory MemoState.errorFetching(LocalizedError error) =
      ErrorFetchingMemoState;
}
