import 'package:flutter/material.dart';
import 'package:memo_app/features/localization/extensions/build_context.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveDescriptionField extends StatelessWidget {
  final String formControlName;

  const ReactiveDescriptionField({
    super.key,
    required this.formControlName,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),

    child: ReactiveTextField(
          formControlName: formControlName,
          minLines: 5,
          maxLines: 10,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            labelText: context.l10n?.labelDescription ?? 'labelDescription',
          ),
        ),
  );
}
