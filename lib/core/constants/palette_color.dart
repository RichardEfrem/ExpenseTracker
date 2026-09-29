/// The category color choices (DESIGN §4.3): ten hues plus a neutral.
///
/// Stored by [name] in the database; each theme maps it to a tuned light or
/// dark shade, so a category keeps its meaning in both themes.
enum PaletteColor {
  orange,
  blue,
  green,
  purple,
  pink,
  teal,
  violet,
  amber,
  brown,
  emerald,
  neutral;

  static PaletteColor fromName(String name) => PaletteColor.values.firstWhere(
    (c) => c.name == name,
    orElse: () => PaletteColor.neutral,
  );
}
