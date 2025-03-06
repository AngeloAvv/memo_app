import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo_app/blocs/memo/memo_bloc.dart';
import 'package:memo_app/cubits/memo/memo_cubit.dart' as cubit;
import 'package:memo_app/features/localization/extensions/build_context.dart';
import 'package:memo_app/features/routing/app_router.dart';
import 'package:memo_app/models/memo/memo.dart';
import 'package:memo_app/pages/main/widgets/add_fab.dart';
import 'package:memo_app/pages/main/widgets/empty_memo_courtesy.dart';
import 'package:memo_app/pages/main/widgets/error_memo_courtesy.dart';
import 'package:memo_app/pages/main/widgets/memo_card.dart';
import 'package:memo_app/widgets/loading_widget.dart';

/// Enter the Main documentation here
@RoutePage()
class MainPage extends StatelessWidget implements AutoRouteWrapper {
  /// The constructor of the page.
  const MainPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider<MemoBloc>(
        create: (context) => MemoBloc(memoRepository: context.read()),
      ),
      BlocProvider<cubit.MemoCubit>(
        create:
            (context) =>
                cubit.MemoCubit(memoRepository: context.read())..fetch(),
      ),
    ],
    child: this,
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(context.l10n?.appName ?? 'appName')),
    body: BlocBuilder<cubit.MemoCubit, cubit.MemoState>(
      builder:
          (context, state) => switch (state) {
            cubit.FetchingMemoState() => const LoadingWidget(),
            cubit.FetchedMemoState(:final memos) => ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (_, __ )=> const SizedBox(height: 8.0),
              itemBuilder: (context, index) {
                final memo = memos[index];

                return MemoCard(
                  memo,
                  onDismissed: () => _removeMemo(context, memo),
                );
              },
              itemCount: memos.length,
            ),
            cubit.EmptyMemoState() => EmptyMemoCourtesy(
              onTap: () => context.router.push(const CreateMemoRoute()),
            ),
            cubit.ErrorFetchingMemoState() => const ErrorMemoCourtesy(),
          },
    ),
    floatingActionButton: BlocSelector<cubit.MemoCubit, cubit.MemoState, bool>(
      selector:
          (state) => switch (state) {
            cubit.FetchedMemoState() => true,
            _ => false,
          },
      builder:
          (context, showButton) => switch (showButton) {
            true => AddFab(
              onPressed: () => context.router.push(const CreateMemoRoute()),
            ),
            false => const SizedBox.shrink(),
          },
    ),
  );

  void _removeMemo(BuildContext context, Memo memo) {
    context.memoBloc.remove(memo.id);
  }
}
