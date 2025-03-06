import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:memo_app/di/dependency_injector.dart';
import 'package:memo_app/features/localization/extensions/build_context.dart';
import 'package:memo_app/features/routing/app_router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  AppRouter? _router;

  @override
  Widget build(BuildContext context) {
    _router ??= AppRouter();

    return DependencyInjector(
      child: MaterialApp.router(
        onGenerateTitle: (context) => context.l10n?.appName ?? 'appName',
        debugShowCheckedModeBanner: false,
        routeInformationParser: _router!.defaultRouteParser(),
        routerDelegate: _router!.delegate(),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
      ),
    );
  }
}
