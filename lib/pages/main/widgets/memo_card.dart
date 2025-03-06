import 'package:flutter/material.dart';
import 'package:memo_app/models/memo/memo.dart';

class MemoCard extends StatelessWidget {
  final Memo memo;
  final VoidCallback? onDismissed;

  const MemoCard(this.memo, {super.key, this.onDismissed});

  @override
  Widget build(BuildContext context) => Dismissible(
    key: Key(memo.id.toString()),
    onDismissed: (_) => onDismissed?.call(),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: ListTile(
          title: Text(memo.title),
          subtitle: Text(memo.description),
        ),
      ),
    ),
  );
}
