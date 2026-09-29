import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

/// The single on-device database file in app-private storage.
QueryExecutor openAppConnection() => driftDatabase(name: 'expense_tracker');
