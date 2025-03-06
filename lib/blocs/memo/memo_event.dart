part of 'memo_bloc.dart';

@freezed
sealed class MemoEvent with _$MemoEvent {
  
  const factory MemoEvent.create( {
    required String title,
    required String description,
}) = CreateMemoEvent;
  
  const factory MemoEvent.remove(int id) = RemoveMemoEvent;
  
}
