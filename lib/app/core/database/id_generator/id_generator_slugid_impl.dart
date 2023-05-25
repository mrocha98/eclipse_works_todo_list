import 'package:slugid/slugid.dart';

import 'id_generator.dart';

class IdGeneratorSlugIdImpl implements IdGenerator {
  @override
  String generate() => Slugid.v4().uuid();
}
