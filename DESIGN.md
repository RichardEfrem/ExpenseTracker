# Design — Local Expense Tracker

**Companion to:** `expense-tracker-prd.md` · **Platform:** Android, Flutter (Material 3) · **Date:** 2026-09-29 · **Status:** Draft v0.1

---

## 1. Design direction in one paragraph

**Calm, neutral surfaces; numbers as the hero; color only where it means something.** The app uses stock Material 3 components with a restrained custom theme: one teal accent, green and red kept strictly for money direction, and category colors used only on category icons and charts. The home screen is a small grid of summary cards (bento-style) for at-a-glance status. Lists and tables stay uniform rows, because they are scanned top to bottom. Every chart pairs color with a label, and every number uses tabular figures so columns of rupiah line up.

---

## 2. Trend research — what we adopt and what we skip

Research from current (2026) finance-app and UI-trend write-ups, filtered for a single-user, offline, Android-only Flutter app.

| Trend | What the sources say | Decision for this app |
| --- | --- | --- |
| **Restrained minimalism** | Fintech UX in 2026 favors clean charts and restrained palettes, limited colors per chart, and hiding what isn't needed to cut cognitive load. ([Design Studio](https://www.designstudiouiux.com/blog/fintech-ux-design-trends/)) | **Adopt.** Neutral surfaces, one accent, ≤ 3 colors per chart except the category donut. |
| **Progressive disclosure** | Leading finance apps show the summary first and details on demand. ([Gummble](https://gummble.com/blog/best-finance-app-designs-2026)) | **Adopt.** Home = totals; tap → report; tap a chart segment → transactions. Add screen hides date/account/note behind chips. |
| **Hierarchy by state** | Dashboards should lead with current position, then what needs attention, then next actions. ([ProCreator](https://procreator.design/blog/finance-app-design-best-practices/)) | **Adopt.** Home order: period net → income/expense → top categories → recent. "Needs attention" = pending recurring items and backup reminder only. |
| **Don't rely on red/green alone** | Pair colors with labels or icons; test for color-blind users. ([ProCreator](https://procreator.design/blog/finance-app-design-best-practices/)) | **Adopt.** Every amount carries a `+` / `−` sign; income/expense also get an arrow icon in summaries. |
| **Bento grid layouts** | Bento layouts are shipping widely, but fail on data-dense views that need uniform scanning, and can confuse screen readers if reading order differs from visual order. ([Rajesh R Nair](https://rajeshrnair.com/blog/design/ui-ux/ui-design-trends-2026-bento-grids-glassmorphism.html)) | **Adopt on Home only.** Reports and transaction lists use uniform rows. Semantics order matches visual order. |
| **Dark mode as a designed theme** | Dark mode needs its own color design, not mechanical inversion. ([Rajesh R Nair](https://rajeshrnair.com/blog/design/ui-ux/ui-design-trends-2026-bento-grids-glassmorphism.html)) | **Adopt.** Separate hand-tuned dark palette (§4.2), all contrast-checked. |
| **Purposeful micro-animation** | Motion should clarify state (loading, button states, drag feedback), not decorate. ([Rajesh R Nair](https://rajeshrnair.com/blog/design/ui-ux/ui-design-trends-2026-bento-grids-glassmorphism.html)) | **Adopt.** Count-up on totals, spring on FAB/sheet, chart grow-in once. |
| **Material 3 Expressive** | Adds button groups, FAB menu, floating toolbars, 35 new shapes with morphing, and spring-based motion; teams can adopt it selectively. ([Supercharge](https://supercharge.design/blog/material-3-expressive)) | **Adopt selectively.** Flutter has **no official** M3 Expressive components; the work is paused while Material is split into its own package. ([flutter/flutter #168813](https://github.com/flutter/flutter/issues/168813)) We borrow the *ideas* (larger radii, spring motion, segmented button groups) using stock M3 widgets, no community package. |
| **Glassmorphism** | Still around in refined form, but hurts text legibility and is GPU-heavy on older Android devices. ([Rajesh R Nair](https://rajeshrnair.com/blog/design/ui-ux/ui-design-trends-2026-bento-grids-glassmorphism.html)) | **Skip.** Solid surfaces only. |
| **Gamification / celebrations** | Badges, streaks and confetti are common engagement tools. ([Design Studio](https://www.designstudiouiux.com/blog/fintech-ux-design-trends/)) | **Mostly skip.** Personal tool, not a growth product. One quiet exception: a "no-spend day" stat. |
| **Voice input, chatbots, cloud sync** | Frequently listed fintech trends. ([Design Studio](https://www.designstudiouiux.com/blog/fintech-ux-design-trends/)) | **Skip.** Out of scope per the PRD (offline, single device). |

---

## 3. Design principles

1. **The number is the interface.** Amounts are the largest, highest-contrast element on any screen that shows them.
2. **Color = meaning.** Green = money in, red = money out, teal = interactive/brand, category color = category. Nothing else gets color.
3. **One thumb.** Primary actions sit in the bottom half: FAB, keypad, Save, bottom sheets. The top bar holds only titles and secondary actions.
4. **Summary → detail → record.** Every summary number can be tapped to reach the transactions behind it.
5. **Uniform where scanned, grouped where glanced.** Lists and tables are uniform rows; the dashboard is cards.
6. **Nothing hidden that you need weekly.** Progressive disclosure hides optional *fields*, never whole features.

---

## 4. Design tokens

All tokens live in `lib/core/theme/` as a Flutter `ThemeData` plus one `ThemeExtension<FinanceColors>` for the semantic colors Material doesn't have.

### 4.1 Color — light

| Token | Hex | Use | Contrast |
| --- | --- | --- | --- |
| `background` | `#F4F7F8` | Scaffold (cool gray tint) | — |
| `surface` | `#FFFFFF` | Cards, sheets, list backgrounds | — |
| `surfaceContainer` | `#EBF1F3` | Chips, keypad keys, input fills, selected rows | — |
| `outline` | `#D9E2E6` | 1 px dividers and card borders | — |
| `onSurface` (text) | `#121A1E` | Primary text, amounts | 17.6:1 on surface |
| `onSurfaceVariant` (text2) | `#56646B` | Labels, dates, captions | 6.1:1 on surface |
| `primary` | `#00718A` | FAB, selected tab, buttons, links | 5.6:1 on surface |
| `onPrimary` | `#FFFFFF` | Text/icons on primary | 5.6:1 |
| `income` | `#067550` | Income amounts, income arrow | 5.7:1 on surface, 5.0:1 on surfaceContainer |
| `expense` | `#C8372D` | Expense accents (arrow, chart bars, over-average markers) | 5.2:1 on surface |
| `transfer` | `#56646B` | Transfer amounts and icon | 6.1:1 on surface |
| `warning` | `#965800` | Backup reminder, pending recurring | 5.7:1 on surface |

### 4.2 Color — dark

| Token | Hex | Contrast |
| --- | --- | --- |
| `background` | `#0D1316` | — |
| `surface` | `#151D21` | — |
| `surfaceContainer` | `#1D272C` | — |
| `outline` | `#2E3B42` | — |
| `onSurface` | `#E8EFF1` | 14.7:1 on surface |
| `onSurfaceVariant` | `#9FAEB5` | 7.5:1 on surface |
| `primary` | `#6FD0E6` | 9.6:1 on surface |
| `onPrimary` | `#00333F` | 7.7:1 on primary |
| `income` | `#4CC99A` | 8.2:1 on surface |
| `expense` | `#FF8A7E` | 7.5:1 on surface |
| `transfer` | `#9FAEB5` | 7.5:1 on surface |
| `warning` | `#F2B84B` | 9.5:1 on surface |

All text pairs pass WCAG AA (≥ 4.5:1) on every surface they appear on. Dark mode uses lighter, desaturated accents instead of the light-mode hues, and separates layers by surface tone rather than shadows.

**Dynamic color (Material You):** off by default. A setting can derive `primary` from the wallpaper, but `income`, `expense`, `transfer`, `warning` and category colors never change, so meaning is stable.

### 4.3 Category palette

Used for category icon circles, donut slices, and trend lines. Each color is ≥ 3:1 against its surface (non-text contrast), and neighbors in the default order have distinct hues.

| Default category | Icon (Material Symbols Rounded) | Light | Dark |
| --- | --- | --- | --- |
| Food & Drinks | `restaurant` | `#E8590C` | `#FF9A5C` |
| Transport | `directions_bus` | `#1971C2` | `#74B3F0` |
| Groceries | `shopping_basket` | `#2B8A3E` | `#69C97D` |
| Bills & Utilities | `receipt_long` | `#9C36B5` | `#D08BE6` |
| Shopping | `shopping_bag` | `#C2255C` | `#F57FA8` |
| Health | `favorite` | `#0C8599` | `#4FC6D6` |
| Entertainment | `movie` | `#6741D9` | `#A48BF5` |
| Education | `school` | `#B07A00` | `#E6B84A` |
| Housing / Rent | `home` | `#8C5A2B` | `#D1A073` |
| Other | `more_horiz` | `#697180` | `#9AA1AD` |
| Salary | `work` | `#0B7552` | `#4CC99A` |
| Freelance | `laptop_mac` | `#1971C2` | `#74B3F0` |
| Gift | `redeem` | `#C2255C` | `#F57FA8` |

- The color picker for custom categories offers exactly these 10 hues (plus the neutral), so every user-made category stays legible in both themes.
- Category icon = 20 dp glyph in white/`#0D1316` on a 36 dp circle of the category color at 100% (light) or 24% tint with colored glyph (dark).
- Donut charts show at most **6 slices**: the top 5 categories + "Other (n)". Beyond 6 hues, colors stop being distinguishable.

### 4.4 Typography

**Font: Inter**, bundled as an asset (variable font, weights 400–700). Do **not** use the `google_fonts` package's runtime fetching: the app has no internet permission. Inter is chosen for its tabular figures (`tnum`) and clear digits (1/l/I, 0/O).

**Every amount uses tabular figures:** `fontFeatures: [FontFeature.tabularFigures()]`, so `Rp 1.250.000` and `Rp 950.000` right-align cleanly.

| Role | M3 style | Size / line height | Weight | Use |
| --- | --- | --- | --- | --- |
| Hero amount | `displaySmall` | 36 / 44 | 600 | Home net, Add-screen amount input |
| Section amount | `headlineSmall` | 24 / 32 | 600 | Summary card values, report totals |
| Screen title | `titleLarge` | 22 / 28 | 600 | App bar titles |
| Card title | `titleMedium` | 16 / 24 | 600 | Card headers, list section headers (dates) |
| Body | `bodyLarge` | 16 / 24 | 400 | Transaction title (category), form text |
| Row amount | `bodyLarge` + tnum | 16 / 24 | 600 | Amounts in lists |
| Secondary | `bodyMedium` | 14 / 20 | 400 | Notes, account names, subtitles |
| Label | `labelLarge` | 14 / 20 | 500 | Buttons, chips, tabs |
| Caption | `labelSmall` | 11 / 16 | 500 | Chart axes, % changes, timestamps |

Text scales with the system font size up to 200% (PRD NFR). Hero amounts use `FittedBox(fit: BoxFit.scaleDown)` so very large numbers shrink instead of wrapping.

### 4.5 Spacing, shape, elevation

| Token | Value |
| --- | --- |
| Base grid | 4 dp; common steps 4 · 8 · 12 · 16 · 24 · 32 |
| Screen side padding | 16 dp |
| Card inner padding | 16 dp |
| Gap between cards | 12 dp |
| List row height | 64 dp (icon + two lines) |
| Min touch target | 48 × 48 dp |
| Radius — small (chips, keys) | 12 dp |
| Radius — medium (cards, inputs) | 16 dp |
| Radius — large (bottom sheets, dialogs) | 28 dp top corners |
| Radius — FAB | 16 dp (standard 56 dp FAB) |
| Elevation | Cards: 0 with 1 dp `outline` border. Sheets and FAB: M3 level 3. No other shadows. |

### 4.6 Motion and haptics

| Moment | Motion | Duration |
| --- | --- | --- |
| Screen transitions | M3 shared-axis (horizontal for tabs, vertical for pushes) | 300 ms, emphasized easing |
| FAB → Add screen | Container transform (FAB morphs into the screen) | 350 ms |
| Bottom sheets | Spring (slight overshoot, `SpringDescription(mass: 1, stiffness: 400, damping: 30)`) | ~300 ms |
| Totals changing | Count-up from old to new value | 400 ms |
| Charts on first load | Bars/lines grow in; donut sweeps | 500 ms, once per screen visit |
| Delete | Row collapses; Undo snackbar | 200 ms |
| Save transaction | `HapticFeedback.lightImpact()` + check icon on the Save button for 300 ms | — |
| Keypad keys | `HapticFeedback.selectionClick()` | — |

When the system "Remove animations" setting is on (`MediaQuery.disableAnimations`), all of the above jump to their end state.

---

## 5. Number and date formatting

| Case | Format | Example |
| --- | --- | --- |
| Full amount | `Rp` + space + `.` thousands, no decimals | `Rp 1.250.000` |
| Expense in lists | `−` + amount, **default text color** | `−Rp 45.000` |
| Income in lists | `+` + amount, **income green** | `+Rp 8.500.000` |
| Transfer | no sign, transfer gray, `→` icon | `Rp 500.000` |
| Net (can be negative) | sign always shown; green if ≥ 0, red if < 0 | `+Rp 2.150.000` / `−Rp 310.000` |
| Compact (chart axes, small cards) | `K` / `M` with `,` decimal, 1 decimal max | `Rp 250K`, `Rp 12,5M` |
| % change | arrow + sign + 1 decimal | `▲ 12,4%` |
| Dates in lists | Section headers: `Today`, `Yesterday`, then `Mon, 28 Sep` | — |
| Month labels | `September 2026`; compact `Sep` | — |

> **PRD change:** the PRD's UX rule "expenses in red with no minus sign" is replaced by the rule above. Expenses are the majority of rows, and a screen full of red reads as an alarm. Explicit `−`/`+` signs also meet the "don't rely on color alone" guidance.

Minus sign is the true minus `−` (U+2212), not a hyphen, so it's as wide as `+` in tabular figures.

---

## 6. Navigation

Four destinations in a bottom `NavigationBar` (Budgets removed), plus a floating action button for adding.

```
┌─────────────────────────────────────────┐
│                                         │
│              (screen content)           │
│                                         │
│                                  ╭────╮ │
│                                  │ ＋ │ │  ← Standard FAB, 16 dp radius
│                                  ╰────╯ │
├─────────────────────────────────────────┤
│  ⌂ Home   ≣ Activity   ◔ Reports   ⋯ More │
└─────────────────────────────────────────┘
```

| Tab | Icon | Screen |
| --- | --- | --- |
| Home | `home` | Dashboard |
| Activity | `receipt_long` | Transaction list + search/filter |
| Reports | `donut_large` | Reports and statistics |
| More | `more_horiz` | Accounts, categories, recurring, backup, settings |

- FAB shows on Home and Activity. Tap = add expense. Long-press = small menu (Expense · Income · Transfer), styled like the M3 Expressive FAB menu.
- "Activity" is used instead of "Transactions" so the label fits at 200% font scale.
- Back from any root tab goes to Home, then exits.

---

## 7. Components

### 7.1 Period selector

Used on Home, Activity and Reports; same widget, same state (the chosen period is shared app-wide).

```
   ‹    September 2026    ›        [ Week | Month | Year | … ]
```

- Center label is tappable → bottom sheet with a M3 `SegmentedButton` (Week · Month · Year · Custom) and a month/year picker.
- `‹ ›` step one period. `›` is disabled for periods after the current one.
- Respects the "start day of month" setting: with start day 25, the label reads `25 Aug – 24 Sep`.

### 7.2 Summary card

```
╭──────────────────────────────╮
│ ↓ Income                     │
│ Rp 8.500.000                 │
│ ▲ 4,0% vs Aug                │
╰──────────────────────────────╯
```

- Title `labelLarge` + direction icon in the semantic color; value `headlineSmall` tnum; delta `labelSmall` in `onSurfaceVariant`.
- For expense, a rise is shown with `▲` but not colored red: the arrow and the word "vs" carry it, color stays neutral. Avoids judging every increase as bad.
- Whole card is tappable (ripple) → filtered report.

### 7.3 Transaction row

```
 ⬤  Food & Drinks                     −Rp 45.000
    Lunch with team · BCA                  12:30
```

- Leading: 36 dp category icon circle. Title: category name (`bodyLarge`). Subtitle: note (if any) · account name (only if > 1 account).
- Trailing: amount (`bodyLarge` 600, tnum) over time (`labelSmall`).
- Recurring-generated rows show a small `repeat` glyph after the note.
- Swipe left → delete (red background, `delete` icon); swipe right → duplicate (primary background, `content_copy` icon). Both also available in the detail screen, since swipes aren't discoverable.

### 7.4 Day group header

```
Today                                 −Rp 128.000
```

`titleMedium` date on the left, daily net on the right in `onSurfaceVariant`. Sticky while scrolling.

### 7.5 Amount keypad

Custom keypad (not the system keyboard) for speed and arithmetic.

```
╭─────────┬─────────┬─────────┬─────────╮
│    7    │    8    │    9    │    ÷    │
├─────────┼─────────┼─────────┼─────────┤
│    4    │    5    │    6    │    ×    │
├─────────┼─────────┼─────────┼─────────┤
│    1    │    2    │    3    │    −    │
├─────────┼─────────┼─────────┼─────────┤
│   000   │    0    │    ⌫    │    +    │
╰─────────┴─────────┴─────────┴─────────╯
```

- Keys: 56 dp tall, `surfaceContainer` fill, 12 dp radius, `headlineSmall` digits.
- `000` key because IDR amounts are almost always thousands.
- Long-press `⌫` clears. When an expression is typed, the live result shows under the amount: `25.000 + 12.500 = Rp 37.500`.
- Operators use `onSurfaceVariant` so digits dominate.

### 7.6 Category grid

- 4 columns of 72 dp cells: icon circle + name (`labelSmall`, max 2 lines, ellipsis).
- Last-used category is pre-selected and shown first.
- Last cell: `＋ New` → create-category sheet.
- Selected state: 2 dp `primary` ring around the icon + name in 600 weight.

### 7.7 Field chips (optional fields on the Add screen)

```
[ 📅 Today ]  [ 💳 Cash ]  [ ✎ Add note ]
```

M3 `InputChip`s. Tapping opens the matching picker (date picker, account sheet, note field). Filled chips show their value: `📅 Mon, 28 Sep`.

### 7.8 Filter chips (Activity)

Horizontally scrolling `FilterChip`s under the search bar: `Type`, `Category`, `Account`, `Date`, `Amount`. An active chip shows its value (`Category: Food, Transport`) and an `×`. A result bar appears when any filter is active: `23 transactions · −Rp 1.240.000`.

### 7.9 Chart card

```
╭──────────────────────────────────────╮
│ Spending by category          Month ▾│
│                                      │
│   (donut)        Food        42%     │
│                  Transport   18%     │
│                  Groceries   15%     │
│                  …                   │
│ Total −Rp 4.380.000                  │
╰──────────────────────────────────────╯
```

- Title `titleMedium`; direct labels next to data instead of a separate legend wherever possible.
- Every chart has a text summary exposed to TalkBack, e.g. "Spending by category, September. Food 42 percent, Rp 1.840.000. Transport 18 percent…".
- Gridlines: `outline` at 50% opacity, horizontal only. No chart borders, no 3D, no gradients.
- Tapping a bar/slice/point selects it (others dim to 40%) and shows a tooltip; a second tap opens the filtered Activity list.

### 7.10 Empty states

Icon (48 dp, `onSurfaceVariant`) + one line of text + one button. No illustrations.

| Where | Text | Button |
| --- | --- | --- |
| Home, no data | "No transactions yet. Add your first expense to see your month." | Add expense |
| Activity, no results for filter | "Nothing matches these filters." | Clear filters |
| Reports, empty period | "No data for September." | Go to last month with data |
| Recurring | "Add rent, salary or subscriptions once and they'll appear automatically." | New recurring |

### 7.11 Feedback

- **Snackbar** for undoable results: "Transaction deleted · UNDO" (5 s).
- **Dialog** only for irreversible actions: restore-replace, erase all data, delete account.
- **Banner** (M3 `MaterialBanner`, `warning` icon) for the backup reminder on Home: "Last backup 34 days ago · BACK UP NOW · LATER".

---

## 8. Screens

### 8.1 Home

Bento-style: one full-width hero card, two half-width cards, then full-width sections.

```
┌─────────────────────────────────────────┐
│ Good afternoon                     🔒 ⚙ │
│ ╭─────────────────────────────────────╮ │
│ │ Total balance                       │ │
│ │ Rp 14.320.000                       │ │  ← today, active accounts
│ │ ⬤ Cash      ⬤ BCA         ⬤ GoPay   │ │  ← only with >1 account;
│ │ Rp 820.000  Rp 12.500.000 Rp 1.000.0│ │    scrolls sideways
│ ╰─────────────────────────────────────╯ │
│   ‹    September 2026    ›              │
│ ╭─────────────────────────────────────╮ │
│ │ Net this month                      │ │
│ │ +Rp 2.150.000                       │ │  ← hero, green/red by sign
│ │ ▲ 12,4% vs Aug                      │ │
│ ╰─────────────────────────────────────╯ │
│ ╭────────────────╮ ╭──────────────────╮ │
│ │ ↓ Income       │ │ ↑ Expense        │ │
│ │ Rp 8.500.000   │ │ Rp 6.350.000     │ │
│ │ ▲ 4,0%         │ │ ▼ 2,1%           │ │
│ ╰────────────────╯ ╰──────────────────╯ │
│ ⚠ 2 recurring items to confirm   REVIEW │  ← only when present
│ ╭─────────────────────────────────────╮ │
│ │ Top spending                        │ │
│ │ ⬤ Food & Drinks  ████████  1.840.000│ │
│ │ ⬤ Transport      ████      790.000  │ │
│ │ ⬤ Groceries      ███       655.000  │ │
│ ╰─────────────────────────────────────╯ │
│ Recent                         See all  │
│  ⬤ Food & Drinks            −Rp 45.000 │
│  ⬤ Transport                −Rp 20.000 │
│  …(5 rows)                              │
├─────────────────────────────────────────┤
│  Home   Activity   Reports   More   (＋) │
└─────────────────────────────────────────┘
```

- Top spending uses horizontal bars in category color, not a donut: easier to compare 3 values in a narrow card.
- The balance card sits above the period selector because it doesn't follow the period: it is today's balance. The per-account row appears only when more than one active account exists. Tapping the total opens Accounts; tapping an account opens Activity filtered to it.

### 8.2 Add / edit transaction (full-screen, opened from FAB)

```
┌─────────────────────────────────────────┐
│ ✕                                       │
│      [ Expense | Income | Transfer ]    │  ← SegmentedButton
│                                         │
│              Rp 37.500                  │  ← hero amount, live
│        25.000 + 12.500                  │  ← expression, only if used
│                                         │
│  [📅 Today] [💳 Cash] [✎ Add note]       │
│                                         │
│  ⬤Food  ⬤Transp ⬤Groc  ⬤Bills           │
│  ⬤Shop  ⬤Health ⬤Ent   ⬤Edu             │  ← category grid (scrolls)
│  ⬤Home  ⬤Other  ＋New                   │
│ ─────────────────────────────────────── │
│   7    8    9    ÷                      │
│   4    5    6    ×                      │
│   1    2    3    −                      │
│  000   0    ⌫    +                      │
│ ╭─────────────────────────────────────╮ │
│ │                Save                 │ │  ← FilledButton, 56 dp
│ ╰─────────────────────────────────────╯ │
└─────────────────────────────────────────┘
```

- Opens with the keypad active; the amount is the only required tap sequence (amount → category → Save = PRD's 3-tap target, since the last-used category is preselected).
- **Transfer mode** replaces the category grid with two account pickers: `From [Cash ▾]  →  To [BCA ▾]`.
- The segmented control tints the hero amount: expense = `onSurface`, income = `income`, transfer = `transfer`.
- Save is disabled until amount > 0 and a category (or both accounts) is set.
- Edit mode: title "Edit transaction", ✕ becomes ←, and a `delete` icon appears top-right.

### 8.3 Activity

```
┌─────────────────────────────────────────┐
│ Activity                                │
│ ╭─────────────────────────────────────╮ │
│ │ Total balance + per account (§8.1)  │ │
│ ╰─────────────────────────────────────╯ │
│ ╭─────────────────────────────────────╮ │
│ │ 🔍 Search notes or categories       │ │
│ ╰─────────────────────────────────────╯ │
│ [Type ▾] [Category ▾] [Account ▾] [Date▾]│
│   ‹    September 2026    ›              │
│   In +Rp 8.500.000   Out −Rp 6.350.000  │
│ Today                       −Rp 128.000 │
│  ⬤ Food & Drinks            −Rp 45.000 │
│    Lunch with team               12:30  │
│  ⬤ Transport                −Rp 20.000 │
│ Yesterday                 +Rp 1.180.000 │
│  ⬤ Freelance             +Rp 1.500.000 │
│  …                                      │
└─────────────────────────────────────────┘
```

- Scrolling past the month's end loads the previous month (PRD TX-09); the period label updates to match.
- When a search/filter is active, the period selector becomes the Date filter chip and the summary line shows the filter result instead.
- The balance card is the same one as on Home; tapping an account sets the Account filter.

### 8.4 Transaction detail (bottom sheet, 90% height)

Category icon + name, hero amount, then a label/value list: Type, Date & time, Account, Note, Recurring rule (link), Created. Actions at the bottom: `Edit` (filled), `Duplicate` (tonal), `Delete` (text, expense color).

### 8.5 Reports

```
┌─────────────────────────────────────────┐
│ Reports                   [All accounts▾]│
│   ‹    September 2026    ›              │
│ ╭────────╮╭────────╮╭────────╮╭────────╮ │  ← stat cards, horizontal scroll
│ │Savings ││Avg/day ││Projected││No-spend│ │
│ │ 25,3%  ││Rp 212K ││Rp 6,4M ││ 6 days │ │
│ ╰────────╯╰────────╯╰────────╯╰────────╯ │
│ [Categories][Trends][Daily][Compare][Calendar]
│ ╭─────────────────────────────────────╮ │
│ │           (active report)           │ │
│ ╰─────────────────────────────────────╯ │
└─────────────────────────────────────────┘
```

Tabs are a scrollable M3 `TabBar` (primary variant). Each tab is one report from the PRD catalog:

| Tab | Report (PRD ID) | Chart spec |
| --- | --- | --- |
| Categories | RPT-01 | Expense/Income toggle. Donut (≤ 6 slices, 56% inner radius, total in the hole) + ranked list: icon · name · bar · amount · % · count. |
| Trends | RPT-02, RPT-04 | Grouped bars per month (income `income`, expense `expense`, 6 or 12 months) + net as a `primary` line with dots. Below: "Category trend" with multi-select chips (≤ 4 categories) drawing one line each in category colors. |
| Daily | RPT-03 | One bar per day (expense color at 70%), dashed `onSurfaceVariant` average line with a direct label "avg Rp 212K". Today's bar outlined. |
| Compare | RPT-05 | Table: category · this · previous · Δ · Δ%. Δ uses ▲/▼ + sign; sorted by absolute Δ. |
| Calendar | RPT-06 | Month grid; each day cell tinted by daily net: green scale for positive, red scale for negative, 5 steps each; the day's net printed in `labelSmall` compact. Tap day → that day in Activity. |

Account balance over time (RPT-07) lives on the Accounts screen, where it's looked for. The tag report (RPT-08, P2) will be a sixth tab.

**Stat cards** (PRD §5.3): Savings rate, Avg daily spend, Projected month-end (current month only), No-spend days, Largest expense, Most frequent category. Each is 120 × 88 dp; tap → explanation sheet with the definition.

### 8.6 More

A plain M3 list grouped into sections:

```
Money         Accounts · Categories · Recurring
Data          Backup & restore · Export CSV
Preferences   Currency & format · Month start day · Week start · Theme · App lock
About         Version · Erase all data
```

### 8.7 Accounts

List of account cards: icon, name, type, balance (`headlineSmall`). Above them, a total balance line and the **balance-over-time line chart** (RPT-07), one line per account in the category-palette order. Actions: add account, transfer, adjust balance (from each account's detail).

### 8.8 Categories

`Expense | Income` segmented tabs. Rows: drag handle · icon · name · transaction count. Tap → edit sheet (name, icon picker grid, color picker with the 10 palette hues). Overflow menu per row: Archive, Merge into… Archived categories collapse into an "Archived (n)" section at the bottom.

### 8.9 Recurring

Pending items first (warning tint card: "Rent · Rp 3.000.000 · due 25 Sep · CONFIRM · SKIP"), then rules: icon · name · amount · frequency · next date. New/edit rule uses the Add screen layout plus a "Repeat" chip (Daily / Weekly / Monthly on day N / Yearly, start, end).

### 8.10 Backup & restore

```
Last backup: 3 days ago (28 Sep, 21:04)
[ Export backup ]            ← FilledButton
[ Restore from file ]        ← OutlinedButton
Encrypt backups with a password     ( toggle )
Weekly auto-backup to folder        ( toggle ) → folder picker
Remind me if no backup for 30 days  ( toggle )
─────
Export CSV   Date range [ This year ▾ ]   [ Export ]
```

Restore preview sheet: "412 transactions · 5 accounts · Jan 2026 – Sep 2026", then `Replace all` (dialog confirm) or `Merge`.

### 8.11 App lock

Full-screen, `background` color, app icon, "Unlock" + biometric prompt auto-shown; PIN pad reuses the amount keypad style (digits only, 4–6 dots). While locked, `FLAG_SECURE` hides content in the recents switcher.

### 8.12 Onboarding (first launch)

Three pages with a progress dot row and `Skip` top-right:

1. **Currency** — preselected "Indonesian Rupiah (Rp)"; format preview `Rp 1.250.000`.
2. **Categories** — the default grid with toggles to remove any.
3. **Starting cash** — amount keypad for the Cash account's opening balance (optional).

---

## 9. Accessibility checklist

- [ ] All text ≥ 4.5:1; icons, chart marks and focus rings ≥ 3:1 (palette pre-checked in §4).
- [ ] Every icon button has a `tooltip`/`semanticLabel`; category icons read as the category name.
- [ ] Amounts read with sign and currency: "minus 45 thousand rupiah", not "dash R p 45 dot 000" — custom `Semantics(label:)` on amount widgets.
- [ ] Each chart has a text summary (§7.9); calendar cells read "28 September, net minus 128 thousand rupiah".
- [ ] Home card reading order = visual order (hero → income → expense → top spending → recent).
- [ ] Layouts tested at 200% font scale and at 360 dp width.
- [ ] Swipe actions all have non-gesture alternatives.
- [ ] `disableAnimations` respected (§4.6).

---

## 10. Flutter implementation notes

| Concern | Approach |
| --- | --- |
| Theme | `ThemeData(useMaterial3: true, colorScheme: ColorScheme(...))` built from §4 tokens, one for light and one for dark; `ThemeMode` from settings. |
| Semantic colors | `class FinanceColors extends ThemeExtension<FinanceColors>` with `income`, `expense`, `transfer`, `warning`, `categoryPalette`; read via `Theme.of(context).extension<FinanceColors>()!`. |
| Font | Inter variable `.ttf` in `assets/fonts/`, declared in `pubspec.yaml`; `textTheme` built with `fontFamily: 'Inter'`. |
| Tabular numbers | A single `MoneyText` widget that applies `FontFeature.tabularFigures()`, sign, color and semantics — never format amounts ad hoc. |
| Icons | `material_symbols_icons` package (bundled font, works offline), Rounded style, weight 400, fill 0 (1 when selected). |
| Formatting | `NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)`; compact formatter in one `MoneyFormat` class. |
| Charts | `fl_chart` with a shared `ChartStyle` (gridlines, axis text, tooltip) so all reports look the same. |
| M3 Expressive | Not available officially in Flutter; approximate with stock widgets: larger FAB radius, `SegmentedButton` groups, spring `AnimationController` for sheets. Revisit when the decoupled Material package ships Expressive components. |
| Security | `FLAG_SECURE` via a small platform channel (or `flutter_windowmanager_plus`) only while app lock is on. |

---

## 11. Changes this design makes to the PRD

| PRD item | Change |
| --- | --- |
| §7 UX rule "expenses in red with no minus sign" | Replaced: expenses `−Rp` in default text color, income `+Rp` in green (§5). |
| §7 navigation diagram | 4 tabs: Home · Activity · Reports · More (Budgets already removed; "Transactions" renamed "Activity"). |
| RPT-07 Account balance over time | Shown on the Accounts screen instead of a Reports tab. |

---

## Sources

- [7 Latest Fintech UX Design Trends & Case Studies for 2026 — Design Studio UI/UX](https://www.designstudiouiux.com/blog/fintech-ux-design-trends/)
- [15 Best Finance App Designs in 2026 — Gummble](https://gummble.com/blog/best-finance-app-designs-2026)
- [6 Finance App Design Strategies for 2026 — ProCreator](https://procreator.design/blog/finance-app-design-best-practices/)
- [UI Design Trends 2026: Bento Grids, Glassmorphism, and What's Actually Shipping — Rajesh R Nair](https://rajeshrnair.com/blog/design/ui-ux/ui-design-trends-2026-bento-grids-glassmorphism.html)
- [Material 3 Expressive: New Components, Motion, Shapes, and More — Supercharge](https://supercharge.design/blog/material-3-expressive)
- [Bring Material 3 Expressive to Flutter — flutter/flutter issue #168813](https://github.com/flutter/flutter/issues/168813)