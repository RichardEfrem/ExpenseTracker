import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/guard.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

void main() {
  group('mapException', () {
    final cases = <String, (Object, Type)>{
      'FailureException unwraps its failure': (
        const FailureException(
          Failure.validation(ValidationReason.invalidInput),
        ),
        ValidationFailure,
      ),
      'SqliteException': (
        SqliteException(extendedResultCode: 19, message: 'constraint'),
        DatabaseFailure,
      ),
      'DriftWrappedException': (
        DriftWrappedException(message: 'wrapped'),
        DatabaseFailure,
      ),
      'CouldNotRollBackException': (
        CouldNotRollBackException(
          Exception('a'),
          StackTrace.empty,
          Exception('b'),
        ),
        DatabaseFailure,
      ),
      'InvalidDataException': (
        InvalidDataException('bad row'),
        DatabaseFailure,
      ),
      'FileSystemException': (const FileSystemException('nope'), FileFailure),
      'PathNotFoundException': (
        const PathNotFoundException('/x', OSError()),
        FileFailure,
      ),
      'anything else': (StateError('boom'), UnexpectedFailure),
    };
    for (final MapEntry(key: name, value: (error, type)) in cases.entries) {
      test(name, () => expect(mapException(error).runtimeType, type));
    }

    test('keeps the exact failure carried by FailureException', () {
      const failure = Failure.backup(BackupProblem.unsupportedVersion);
      expect(mapException(const FailureException(failure)), failure);
    });
  });

  test('guard returns Right on success and Left on throw', () async {
    expect(await guard(() async => 42), const Right<Failure, int>(42));
    final result = await guard<int>(() async => throw StateError('x'));
    expect(result.getLeft().toNullable(), isA<UnexpectedFailure>());
  });

  test('guardSync returns Right on success and Left on throw', () {
    expect(guardSync(() => 'a'), const Right<Failure, String>('a'));
    expect(
      guardSync<int>(
        () => throw const FileSystemException('x'),
      ).getLeft().toNullable(),
      isA<FileFailure>(),
    );
  });

  test('guardStream turns errors into Left and keeps listening', () async {
    final controller = StreamController<int>();
    final collected = guardStream(controller.stream).toList();
    controller
      ..add(1)
      ..addError(InvalidDataException('bad'))
      ..add(2);
    unawaited(controller.close());
    final events = await collected;
    expect(events, hasLength(3));
    expect(events[0], const Right<Failure, int>(1));
    expect(events[1].getLeft().toNullable(), isA<DatabaseFailure>());
    expect(events[2], const Right<Failure, int>(2));
  });
}
