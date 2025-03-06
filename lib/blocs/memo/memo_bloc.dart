import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_essentials_kit/flutter_essentials_kit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:memo_app/errors/generic_error.dart';
import 'package:memo_app/repositories/memo_repository.dart';

part 'memo_bloc.freezed.dart';
part 'memo_event.dart';
part 'memo_state.dart';

/// The MemoBloc
class MemoBloc extends Bloc<MemoEvent, MemoState> {
  final MemoRepository memoRepository;

  /// Create a new instance of [MemoBloc].
  MemoBloc({required this.memoRepository}) : super(const MemoState.initial()) {
    on<CreateMemoEvent>(_onCreate);
    on<RemoveMemoEvent>(_onRemove);
  }

  /// Method used to add the [CreateMemoEvent] event
  void create({required String title, required String description}) =>
      add(MemoEvent.create(title: title, description: description));

  /// Method used to add the [RemoveMemoEvent] event
  void remove(int id) => add(MemoEvent.remove(id));

  FutureOr<void> _onCreate(
    CreateMemoEvent event,
    Emitter<MemoState> emit,
  ) async {
    emit(const MemoState.creating());

    try {
      await memoRepository.create(
        title: event.title,
        description: event.description,
      );

      emit(const MemoState.created());
    } on LocalizedError catch (error) {
      emit(MemoState.errorCreating(error));
    } catch (_) {
      emit(MemoState.errorCreating(GenericError()));
    }
  }

  FutureOr<void> _onRemove(
    RemoveMemoEvent event,
    Emitter<MemoState> emit,
  ) async {
    emit(const MemoState.removing());

    try {
      await memoRepository.remove(event.id);

      emit(const MemoState.removed());
    } on LocalizedError catch (error) {
      emit(MemoState.errorRemoving(error));
    } catch (_) {
      emit(MemoState.errorRemoving(GenericError()));
    }
  }
}

extension MemoBlocExtension on BuildContext {
  /// Extension method used to get the [MemoBloc] instance
  MemoBloc get memoBloc => read<MemoBloc>();
}
