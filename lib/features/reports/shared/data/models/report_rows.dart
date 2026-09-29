import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/utils/local_date.dart';

typedef TotalsRow = ({int income, int expense});

typedef BucketRow = ({int bucket, int income, int expense});

typedef CategoryBucketRow = ({int bucket, CategoryRow category, int amount});

typedef LargestExpenseRow = ({
  String id,
  int amount,
  LocalDate date,
  String? categoryId,
});

typedef CategoryCountRow = ({String categoryId, int count});
