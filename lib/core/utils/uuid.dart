import 'package:uuid/uuid.dart';

/// Makes row IDs. UUID v4, so imported backups never collide (PRD §6.2).
abstract interface class IdGenerator {
  String newId();
}

class UuidGenerator implements IdGenerator {
  const UuidGenerator();

  static const _uuid = Uuid();

  @override
  String newId() => _uuid.v4();
}
