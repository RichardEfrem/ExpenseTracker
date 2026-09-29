import 'package:expense_tracker/core/theme/motion.dart';
import 'package:flutter/widgets.dart';

/// Bars and lines grow in and donuts sweep, once per screen visit
/// (DESIGN §4.6). [builder] gets 0 → 1; 1 at once when motion is off.
class GrowIn extends StatefulWidget {
  const GrowIn({required this.builder, super.key});

  final Widget Function(BuildContext context, double progress) builder;

  @override
  State<GrowIn> createState() => _GrowInState();
}

class _GrowInState extends State<GrowIn> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: Motion.chartGrow,
  );
  late final _curve = CurvedAnimation(
    parent: _controller,
    curve: Motion.emphasizedDecelerate,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (reduceMotion(context)) {
      _controller.value = 1;
    } else if (!_controller.isAnimating && _controller.value == 0) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _curve.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _curve,
    builder: (context, _) => widget.builder(context, _curve.value),
  );
}
