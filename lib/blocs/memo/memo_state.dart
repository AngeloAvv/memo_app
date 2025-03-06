part of 'memo_bloc.dart';

@freezed
sealed class MemoState with _$MemoState {
  const factory MemoState.initial() = InitialMemoState;

  const factory MemoState.creating() = CreatingMemoState;

  const factory MemoState.created() = CreatedMemoState;

  const factory MemoState.errorCreating(LocalizedError error) =
      ErrorCreatingMemoState;

  const factory MemoState.removing() = RemovingMemoState;

  const factory MemoState.removed() = RemovedMemoState;

  const factory MemoState.errorRemoving(LocalizedError error) =
      ErrorRemovingMemoState;
}
