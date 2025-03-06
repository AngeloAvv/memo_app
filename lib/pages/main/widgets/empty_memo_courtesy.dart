import 'package:flutter/material.dart';
import 'package:memo_app/features/localization/extensions/build_context.dart';

class EmptyMemoCourtesy extends StatelessWidget {
  final GestureTapCallback? onTap;

  const EmptyMemoCourtesy({super.key, this.onTap});

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          context.l10n?.labelNoMemosTitle ?? 'labelNoMemosTitle',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            context.l10n?.labelNoMemosSubtitle ?? 'labelNoMemosSubtitle',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        if (onTap != null)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: onTap,
              child: Text(context.l10n?.actionCreate ?? 'actionCreate'),
            ),
          ),
      ],
    ),
  );
}
