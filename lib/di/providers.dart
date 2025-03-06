part of 'dependency_injector.dart';

final List<SingleChildWidget> _providers = [
  Provider<Talker>.value(value: Talker()),
  Provider<MemoDatabase>(
    create: (_) => MemoDatabase(driftDatabase(name: K.databaseName)),
    dispose: (_, db) => db.close(),
  ),
];
