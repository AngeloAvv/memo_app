import 'package:freezed_annotation/freezed_annotation.dart';

part 'memo.freezed.dart';

@freezed
class Memo with _$Memo {
  const Memo._();

  const factory Memo({
    required int id,
    required String title,
    required String description,
    required DateTime createdAt,
  }) = _Memo;
}
