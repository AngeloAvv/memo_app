import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo_app/features/database/memo_database.dart';
import 'package:memo_app/misc/constants.dart';
import 'package:memo_app/repositories/mappers/memo_mapper.dart';
import 'package:memo_app/repositories/memo_repository.dart';
import 'package:pine/pine.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:talker/talker.dart';


part 'providers.dart';
part 'repositories.dart';

class DependencyInjector extends StatelessWidget {
  final Widget child;

  const DependencyInjector({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => DependencyInjectorHelper(
        providers: _providers,
        repositories: _repositories,
        child: child,
      );
}
