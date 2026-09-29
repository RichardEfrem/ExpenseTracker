import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

/// Runs [body] and returns its result as `Right`, or the mapped [Failure] as
/// `Left`. The only place exceptions are turned into failures.
Future<Either<Failure, T>> guard<T>(Future<T> Function() body) async {
  try {
    return Right(await body());
  } catch (error) {
    return Left(mapException(error));
  }
}

/// Synchronous variant of [guard].
Either<Failure, T> guardSync<T>(T Function() body) {
  try {
    return Right(body());
  } catch (error) {
    return Left(mapException(error));
  }
}

/// Wraps each event of [stream] in `Right` and each error in `Left`, so a
/// watched query never throws into presentation.
Stream<Either<Failure, T>> guardStream<T>(Stream<T> stream) {
  return stream.transform(
    StreamTransformer<T, Either<Failure, T>>.fromHandlers(
      handleData: (data, sink) => sink.add(Right(data)),
      handleError: (error, _, sink) => sink.add(Left(mapException(error))),
    ),
  );
}

/// Maps any thrown object to a typed [Failure].
Failure mapException(Object error) => switch (error) {
  FailureException(:final failure) => failure,
  SqliteException() ||
  DriftWrappedException() ||
  CouldNotRollBackException() ||
  InvalidDataException() => Failure.database(error.toString()),
  FileSystemException() => Failure.file(error.toString()),
  _ => Failure.unexpected(error.toString()),
};
