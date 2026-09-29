import 'package:expense_tracker/core/utils/uuid.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'uuid_provider.g.dart';

@Riverpod(keepAlive: true)
IdGenerator idGenerator(Ref ref) => const UuidGenerator();
