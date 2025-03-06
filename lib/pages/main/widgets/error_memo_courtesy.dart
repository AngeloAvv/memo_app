import 'package:flutter/material.dart';
import 'package:memo_app/features/localization/extensions/build_context.dart';

class ErrorMemoCourtesy extends StatelessWidget {
  const ErrorMemoCourtesy({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          context.l10n?.labelErrorMemosTitle ?? 'labelErrorMemosTitle',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            context.l10n?.labelErrorMemosSubtitle ?? 'labelErrorMemosSubtitle',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    ),
  );
}
