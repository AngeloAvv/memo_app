import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_essentials_kit/flutter_essentials_kit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:memo_app/errors/generic_error.dart';
import 'package:memo_app/models/memo/memo.dart';
import 'package:memo_app/repositories/memo_repository.dart';

part 'memo_cubit.freezed.dart';
part 'memo_state.dart';

/// The MemoCubit
class MemoCubit extends Cubit<MemoState> {
  final MemoRepository memoRepository;

  StreamSubscription<List<Memo>>? _subscription;

  /// Create a new instance of [MemoCubit].
  MemoCubit({required this.memoRepository}) : super(const MemoState.fetching());

  /// Method used to perform the [fetch] action
  void fetch() {
    _subscription = memoRepository.fetch().listen(
      (memos) {
        emit(
          memos.isNotEmpty ? MemoState.fetched(memos) : const MemoState.empty(),
        );
      },
      onError: (error) {
        if (error is LocalizedError) {
          emit(MemoState.errorFetching(error));
        } else {
          emit(MemoState.errorFetching(GenericError()));
        }
      },
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();

    return super.close();
  }
}

extension MemoCubitExtension on BuildContext {
  /// Extension method used to get the [MemoCubit] instance
  MemoCubit get memoCubit => read<MemoCubit>();
}
