/// A `moves(acct, day, delta)` CTE: every balance movement as (account,
/// day, signed delta). A transfer leaves one account and enters another;
/// an adjustment enters its account when `to_account_id` is set, else
/// leaves it (PRD ACC-03/05). An account's balance is its opening balance
/// plus the sum of its deltas.
const balanceMovesCte = '''
WITH moves(acct, day, delta) AS (
  SELECT account_id, date, CASE type
    WHEN 'income' THEN amount
    WHEN 'expense' THEN -amount
    WHEN 'transfer' THEN -amount
    WHEN 'adjustment' THEN CASE WHEN to_account_id IS NULL THEN -amount ELSE 0 END
    ELSE 0 END
  FROM transactions
  UNION ALL
  SELECT to_account_id, date, amount FROM transactions
  WHERE to_account_id IS NOT NULL AND type IN ('transfer', 'adjustment')
)''';
