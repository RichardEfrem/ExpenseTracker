import 'package:expense_tracker/core/theme/motion.dart';
import 'package:flutter/widgets.dart';

/// Animates from the previous [value] to the new one (DESIGN §4.6, 400 ms).
/// The first build shows [value] directly; reduce motion skips the animation.
class CountUpText extends StatelessWidget {
  const CountUpText({required this.value, required this.builder, super.key});

  final int value;
  final Widget Function(BuildContext context, int value) builder;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: value.toDouble(), end: value.toDouble()),
      duration: motionDuration(context, Motion.countUp),
      curve: Motion.emphasizedDecelerate,
      builder: (context, animated, _) => builder(context, animated.round()),
    );
  }
}
