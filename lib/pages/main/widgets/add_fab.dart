import 'package:flutter/material.dart';

class AddFab extends StatelessWidget {
  final GestureTapCallback? onPressed;

  const AddFab({super.key, this.onPressed,});

  @override
  Widget build(BuildContext context) => FloatingActionButton(
    onPressed: onPressed,
    child: const Icon(Icons.add),
  );
}
