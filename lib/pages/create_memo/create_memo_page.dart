import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo_app/blocs/memo/memo_bloc.dart';
import 'package:memo_app/features/localization/extensions/build_context.dart';
import 'package:memo_app/pages/create_memo/widgets/create_button.dart';
import 'package:memo_app/pages/create_memo/widgets/reactive_description_field.dart';
import 'package:memo_app/pages/create_memo/widgets/reactive_title_field.dart';
import 'package:memo_app/widgets/loading_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Enter the CreateMemo documentation here
@RoutePage()
class CreateMemoPage extends StatefulWidget implements AutoRouteWrapper {
  static const _kFormTitle = 'title';
  static const _kFormDescription = 'description';

  /// The constructor of the page.
  const CreateMemoPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider<MemoBloc>(
        create: (context) => MemoBloc(memoRepository: context.read()),
      ),
    ],
    child: this,
  );

  @override
  State<CreateMemoPage> createState() => _CreateMemoState();
}

class _CreateMemoState extends State<CreateMemoPage> {
  final _form = FormGroup({
    CreateMemoPage._kFormTitle: FormControl<String>(
      validators: [Validators.required],
    ),
    CreateMemoPage._kFormDescription: FormControl<String>(
      validators: [Validators.required],
    ),
  });

  @override
  Widget build(BuildContext context) => BlocListener<MemoBloc, MemoState>(
    listener:
        (context, state) => switch (state) {
          CreatingMemoState() => _onCreating(context),
          CreatedMemoState() => _onCreated(context),
          ErrorCreatingMemoState() => _onErrorCreating(context),
          _ => null,
        },
    child: Scaffold(
      appBar: AppBar(
        title: Text(context.l10n?.titleCreateMemo ?? 'titleCreateMemo'),
      ),
      body: ReactiveForm(
        formGroup: _form,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          physics: const BouncingScrollPhysics(),
          children: [
            const ReactiveTitleField(
              formControlName: CreateMemoPage._kFormTitle,
            ),
            const ReactiveDescriptionField(
              formControlName: CreateMemoPage._kFormDescription,
            ),
            BlocBuilder<MemoBloc, MemoState>(
              builder:
                  (context, state) => switch (state) {
                    CreatingMemoState() => const LoadingWidget(),
                    _ => CreateButton(onPressed: () => _createMemo(context)),
                  },
            ),
          ],
        ),
      ),
    ),
  );

  void _createMemo(BuildContext context) {
    final title = _form.control(CreateMemoPage._kFormTitle).value;
    final description = _form.control(CreateMemoPage._kFormDescription).value;

    context.memoBloc.create(title: title, description: description);
  }

  void _onCreating(BuildContext context) {
    _form.markAsDisabled();
  }

  void _onCreated(BuildContext context) {
    _form.markAsEnabled();

    context.maybePop();
  }

  void _onErrorCreating(BuildContext context) {
    _form.markAsEnabled();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          context.l10n?.snackbarErrorCreatingMemo ??
              'snackbarErrorCreatingMemo',
        ),
      ),
    );
  }
}
