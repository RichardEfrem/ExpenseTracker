import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/router/container_transform_page.dart';
import 'package:expense_tracker/core/router/module_routes.dart';
import 'package:expense_tracker/features/transactions/activity/presentation/pages/activity_page.dart';
import 'package:expense_tracker/features/transactions/activity/presentation/providers/filter_query_codec.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/presentation/pages/add_transaction_page.dart';
import 'package:go_router/go_router.dart';

ModuleRoutes transactionsRoutes() => ModuleRoutes(
  tab: StatefulShellBranch(
    routes: [
      GoRoute(
        path: AppPaths.activity,
        builder: (context, state) => ActivityPage(
          initialFilter: FilterQueryCodec.decode(state.uri.queryParameters),
        ),
      ),
    ],
  ),
  routes: [
    GoRoute(
      path: AppPaths.add,
      pageBuilder: (context, state) => ContainerTransformPage<void>(
        key: state.pageKey,
        child: AddTransactionPage(
          initialType: switch (state.uri.queryParameters['type']) {
            'income' => TransactionType.income,
            'transfer' => TransactionType.transfer,
            _ => TransactionType.expense,
          },
        ),
      ),
    ),
    GoRoute(
      path: AppPaths.editTransaction,
      builder: (context, state) =>
          AddTransactionPage(editId: state.pathParameters['id']),
    ),
  ],
);
