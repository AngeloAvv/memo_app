import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:memo_app/features/database/tables/memo/memos_table.drift.dart';

extension MemoEntityFixture on MemoEntity {
  static MemoEntityFixtureFactory factory() => MemoEntityFixtureFactory();
}

class MemoEntityFixtureFactory extends FixtureFactory<MemoEntity> {
  @override
  FixtureDefinition<MemoEntity> definition() => define(
    (faker) => MemoEntity(
      id: faker.guid.guid().hashCode,
      title: faker.lorem.word(),
      description: faker.lorem.sentence(),
      createdAt: faker.date.dateTime(),
    ),
  );
}
