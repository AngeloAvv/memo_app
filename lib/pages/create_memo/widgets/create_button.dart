import 'package:flutter/material.dart';
import 'package:memo_app/features/localization/extensions/build_context.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CreateButton extends StatelessWidget {
  final GestureTapCallback? onPressed;

  const CreateButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) => ReactiveFormConsumer(
    builder:
        (context, form, _) => ElevatedButton(
          onPressed: switch (form.valid) {
            true => onPressed,
            false => null,
          },
          child: Text(context.l10n?.actionCreate ?? 'actionCreate'),
        ),
  );
}
