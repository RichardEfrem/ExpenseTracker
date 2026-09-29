import 'package:flutter/widgets.dart';

/// True when text is scaled up so far that side-by-side label + amount no
/// longer fits a phone row; rows then stack the amount under the label
/// instead of shrinking the user's chosen size (DESIGN §9, 200% font).
bool useStackedLayout(BuildContext context) =>
    MediaQuery.textScalerOf(context).scale(1) > 1.4;
