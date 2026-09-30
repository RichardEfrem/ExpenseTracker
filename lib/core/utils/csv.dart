/// CSV per RFC 4180: comma-separated, CRLF line ends, fields quoted when
/// they hold a comma, quote, CR or LF, quotes doubled inside quotes.
abstract final class Csv {
  static const lineEnd = '\r\n';

  /// UTF-8 byte-order mark, so spreadsheet apps read non-ASCII text right.
  static const bom = '\uFEFF';

  static final _needsQuotes = RegExp('[",\r\n]');

  /// Characters that make a spreadsheet run a cell as a formula.
  static final _formulaStart = RegExp('^[=+\\-@\t\r]');

  static String field(String value) =>
      _needsQuotes.hasMatch(value) ? '"${value.replaceAll('"', '""')}"' : value;

  /// Free text a user typed (notes, names): a leading `=`, `+`, `-`, `@`,
  /// tab or CR is prefixed with `'` so a spreadsheet shows it as text
  /// instead of running it as a formula (CSV injection).
  static String text(String value) =>
      _formulaStart.hasMatch(value) ? "'$value" : value;

  /// One line per row, each ending in CRLF, with a leading [bom].
  static String encode(List<List<String>> rows) {
    final out = StringBuffer(bom);
    for (final row in rows) {
      out
        ..writeAll(row.map(field), ',')
        ..write(lineEnd);
    }
    return out.toString();
  }
}
