import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:memo_app/models/memo/memo.dart';

extension MemoFixture on Memo {
  static MemoFixtureFactory factory() => MemoFixtureFactory();
}

class MemoFixtureFactory extends FixtureFactory<Memo> {
  @override
  FixtureDefinition<Memo> definition() => define(
    (faker) => Memo(
      id: faker.guid.guid().hashCode,
      title: faker.lorem.word(),
      description: faker.lorem.sentence(),
      createdAt: faker.date.dateTime(),
    ),
  );
}
